[CmdletBinding()]
param(
    [ValidateSet('auto', 'all', 'codex', 'claude', 'agents')]
    [string[]]$Target = @('auto'),

    [string]$InstallHome = $env:USERPROFILE,

    [switch]$IncludeClaudeHook
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-RelativeFiles {
    param([Parameter(Mandatory)][string]$Root)

    @(Get-ChildItem -LiteralPath $Root -Recurse -File -Force |
        ForEach-Object { $_.FullName.Substring($Root.Length + 1) } |
        Sort-Object)
}

function Test-TreeEqual {
    param(
        [Parameter(Mandatory)][string]$Expected,
        [Parameter(Mandatory)][string]$Actual
    )

    if (-not (Test-Path -LiteralPath $Actual -PathType Container)) {
        return $false
    }

    $expectedFiles = Get-RelativeFiles -Root $Expected
    $actualFiles = Get-RelativeFiles -Root $Actual
    if (@(Compare-Object $expectedFiles $actualFiles).Count -ne 0) {
        return $false
    }

    foreach ($relativePath in $expectedFiles) {
        $expectedHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $Expected $relativePath)).Hash
        $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $Actual $relativePath)).Hash
        if ($expectedHash -ne $actualHash) {
            return $false
        }
    }

    return $true
}

function Test-FileEqual {
    param(
        [Parameter(Mandatory)][string]$Expected,
        [Parameter(Mandatory)][string]$Actual
    )

    $actualItem = Get-Item -Force -LiteralPath $Actual -ErrorAction SilentlyContinue
    if ($null -eq $actualItem -or $actualItem.PSIsContainer -or
        ($actualItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        return $false
    }

    $expectedHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Expected).Hash
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Actual).Hash
    return $expectedHash -eq $actualHash
}

function Add-UniqueTarget {
    param(
        [Parameter(Mandatory)][AllowEmptyCollection()][System.Collections.Generic.List[string]]$List,
        [Parameter(Mandatory)][string]$Name
    )

    if (-not $List.Contains($Name)) {
        $List.Add($Name)
    }
}

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceRoot = (Resolve-Path -LiteralPath (Join-Path $repoRoot 'skills')).Path
$manifest = Get-Content -Raw -Encoding UTF8 -LiteralPath (Join-Path $repoRoot 'manifest.json') | ConvertFrom-Json
$sourceSkills = @(Get-ChildItem -LiteralPath $sourceRoot -Directory -Filter 'yo-*' -Force | Sort-Object Name)

if ($manifest.skill_count -ne $sourceSkills.Count) {
    throw 'manifest.json does not match the skills/ directory.'
}
if (-not (Test-Path -LiteralPath $InstallHome -PathType Container)) {
    throw "Install home does not exist: $InstallHome"
}
$homePath = (Resolve-Path -LiteralPath $InstallHome).Path

$requested = @($Target | ForEach-Object { $_.ToLowerInvariant() })
if ($requested.Contains('auto') -and $requested.Count -gt 1) {
    throw "'auto' cannot be combined with explicit targets."
}
if ($requested.Contains('all') -and $requested.Count -gt 1) {
    throw "'all' cannot be combined with other targets."
}

$selected = [System.Collections.Generic.List[string]]::new()
if ($requested.Contains('all')) {
    foreach ($name in @('codex', 'claude', 'agents')) {
        Add-UniqueTarget -List $selected -Name $name
    }
}
elseif ($requested.Contains('auto')) {
    if (Test-Path -LiteralPath (Join-Path $homePath '.codex\skills')) {
        Add-UniqueTarget -List $selected -Name 'codex'
    }
    if (Test-Path -LiteralPath (Join-Path $homePath '.claude\skills')) {
        Add-UniqueTarget -List $selected -Name 'claude'
    }
    if (Test-Path -LiteralPath (Join-Path $homePath '.agents\skills')) {
        Add-UniqueTarget -List $selected -Name 'agents'
    }
}
else {
    foreach ($name in $requested) {
        Add-UniqueTarget -List $selected -Name $name
    }
}

if ($selected.Count -eq 0) {
    throw 'No installed target was detected. Use -Target to select one explicitly.'
}
if ($IncludeClaudeHook -and -not $selected.Contains('claude')) {
    throw '-IncludeClaudeHook requires claude to be one of the selected targets.'
}

$targetRoots = @{
    codex  = Join-Path $homePath '.codex\skills'
    claude = Join-Path $homePath '.claude\skills'
    agents = Join-Path $homePath '.agents\skills'
}

$rows = @()
$failed = $false
foreach ($hostName in $selected) {
    $targetRoot = $targetRoots[$hostName]
    $matches = 0
    $mismatches = [System.Collections.Generic.List[string]]::new()

    foreach ($skill in $sourceSkills) {
        if (Test-TreeEqual -Expected $skill.FullName -Actual (Join-Path $targetRoot $skill.Name)) {
            $matches++
        }
        else {
            $mismatches.Add($skill.Name)
            $failed = $true
        }
    }

    $rows += [PSCustomObject]@{
        Host = $hostName
        Matching = $matches
        Expected = $sourceSkills.Count
        Mismatches = ($mismatches -join ', ')
        Target = $targetRoot
    }
}

$rows | Format-Table -AutoSize
if ($IncludeClaudeHook) {
    $hookTargetRoot = Join-Path $homePath '.claude\hooks'
    $hookFiles = @(
        [PSCustomObject]@{
            Name = 'yo-claude-baseline.ps1'
            Source = Join-Path $repoRoot $manifest.optional_assets.claude_session_start_powershell
        },
        [PSCustomObject]@{
            Name = 'yo-claude-baseline.sh'
            Source = Join-Path $repoRoot $manifest.optional_assets.claude_session_start_bash
        }
    )
    $matchingHooks = 0
    $hookMismatches = [System.Collections.Generic.List[string]]::new()
    foreach ($hook in $hookFiles) {
        if (Test-FileEqual -Expected $hook.Source -Actual (Join-Path $hookTargetRoot $hook.Name)) {
            $matchingHooks++
        }
        else {
            $hookMismatches.Add($hook.Name)
            $failed = $true
        }
    }
    Write-Host "Claude hooks: $matchingHooks/$($hookFiles.Count) matching  $hookTargetRoot"
    if ($hookMismatches.Count -gt 0) {
        Write-Host "Mismatches: $($hookMismatches -join ', ')"
    }
}
if ($failed) {
    Write-Error 'Yo Skills verification failed.'
    exit 1
}

Write-Host 'Yo Skills verification passed.' -ForegroundColor Green
