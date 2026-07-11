[CmdletBinding()]
param(
    [ValidateSet('auto', 'all', 'codex', 'claude', 'agents')]
    [string[]]$Target = @('auto'),

    [string]$InstallHome = $env:USERPROFILE
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-RelativeFiles {
    param([Parameter(Mandatory)][string]$Root)

    @(Get-ChildItem -LiteralPath $Root -Recurse -File -Force |
        ForEach-Object { $_.FullName.Substring($Root.Length + 1) } |
        Sort-Object)
}

function Assert-TreeEqual {
    param(
        [Parameter(Mandatory)][string]$Expected,
        [Parameter(Mandatory)][string]$Actual
    )

    if (-not (Test-Path -LiteralPath $Actual -PathType Container)) {
        throw "Missing installed directory: $Actual"
    }

    $expectedFiles = Get-RelativeFiles -Root $Expected
    $actualFiles = Get-RelativeFiles -Root $Actual
    if (@(Compare-Object $expectedFiles $actualFiles).Count -ne 0) {
        throw "File-set mismatch: $Actual"
    }

    foreach ($relativePath in $expectedFiles) {
        $expectedHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $Expected $relativePath)).Hash
        $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $Actual $relativePath)).Hash
        if ($expectedHash -ne $actualHash) {
            throw "Hash mismatch: $Actual\$relativePath"
        }
    }
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
$manifestPath = Join-Path $repoRoot 'manifest.json'
$manifest = Get-Content -Raw -Encoding UTF8 -LiteralPath $manifestPath | ConvertFrom-Json
$sourceSkills = @(Get-ChildItem -LiteralPath $sourceRoot -Directory -Filter 'yo-*' -Force | Sort-Object Name)
$expectedNames = @($manifest.skills | Sort-Object)
$actualNames = @($sourceSkills.Name | Sort-Object)

if ($manifest.skill_count -ne $sourceSkills.Count -or @(Compare-Object $expectedNames $actualNames).Count -ne 0) {
    throw 'manifest.json does not match the skills/ directory.'
}

if (-not (Test-Path -LiteralPath $InstallHome -PathType Container)) {
    New-Item -ItemType Directory -Force -Path $InstallHome | Out-Null
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
    if ((Test-Path -LiteralPath (Join-Path $homePath '.codex')) -or
        ($homePath -eq $env:USERPROFILE -and (Get-Command codex -ErrorAction SilentlyContinue))) {
        Add-UniqueTarget -List $selected -Name 'codex'
    }
    if ((Test-Path -LiteralPath (Join-Path $homePath '.claude')) -or
        ($homePath -eq $env:USERPROFILE -and (Get-Command claude -ErrorAction SilentlyContinue))) {
        Add-UniqueTarget -List $selected -Name 'claude'
    }
    if (Test-Path -LiteralPath (Join-Path $homePath '.agents')) {
        Add-UniqueTarget -List $selected -Name 'agents'
    }
}
else {
    foreach ($name in $requested) {
        Add-UniqueTarget -List $selected -Name $name
    }
}

if ($selected.Count -eq 0) {
    throw 'No supported host was detected. Use -Target codex, -Target claude, or -Target all.'
}

$targetRoots = @{
    codex  = Join-Path $homePath '.codex\skills'
    claude = Join-Path $homePath '.claude\skills'
    agents = Join-Path $homePath '.agents\skills'
}

$stamp = Get-Date -Format 'yyyyMMdd-HHmmssfff'
$backupRoot = Join-Path $homePath ".yo-skills-backups\$stamp"
$stagedRoot = Join-Path $backupRoot 'staged-source'
New-Item -ItemType Directory -Force -Path $stagedRoot | Out-Null

foreach ($skill in $sourceSkills) {
    $stagedSkill = Join-Path $stagedRoot $skill.Name
    Copy-Item -LiteralPath $skill.FullName -Destination $stagedSkill -Recurse -Force
    Assert-TreeEqual -Expected $skill.FullName -Actual $stagedSkill
}

$results = @()
foreach ($hostName in $selected) {
    $targetRoot = $targetRoots[$hostName]
    New-Item -ItemType Directory -Force -Path $targetRoot | Out-Null
    $resolvedTarget = (Resolve-Path -LiteralPath $targetRoot).Path
    $homePrefix = $homePath.TrimEnd('\') + '\'
    if (-not $resolvedTarget.StartsWith($homePrefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to install outside the selected home: $resolvedTarget"
    }

    $oldRoot = Join-Path $backupRoot "old-$hostName-skills"
    $rollbackRoot = Join-Path $backupRoot "failed-$hostName-install"
    New-Item -ItemType Directory -Force -Path $oldRoot | Out-Null
    $backedUp = 0

    try {
        foreach ($skill in $sourceSkills) {
            $installedSkill = Join-Path $resolvedTarget $skill.Name
            if (Test-Path -LiteralPath $installedSkill) {
                Move-Item -LiteralPath $installedSkill -Destination (Join-Path $oldRoot $skill.Name)
                $backedUp++
            }

            Copy-Item -LiteralPath (Join-Path $stagedRoot $skill.Name) -Destination $installedSkill -Recurse -Force
        }

        foreach ($skill in $sourceSkills) {
            Assert-TreeEqual -Expected $skill.FullName -Actual (Join-Path $resolvedTarget $skill.Name)
        }
    }
    catch {
        New-Item -ItemType Directory -Force -Path $rollbackRoot | Out-Null
        foreach ($skill in $sourceSkills) {
            $installedSkill = Join-Path $resolvedTarget $skill.Name
            $oldSkill = Join-Path $oldRoot $skill.Name
            if (Test-Path -LiteralPath $installedSkill) {
                Move-Item -LiteralPath $installedSkill -Destination (Join-Path $rollbackRoot $skill.Name)
            }
            if (Test-Path -LiteralPath $oldSkill) {
                Move-Item -LiteralPath $oldSkill -Destination $installedSkill
            }
        }
        throw
    }

    $results += [PSCustomObject]@{
        Host = $hostName
        Skills = $sourceSkills.Count
        Replaced = $backedUp
        Target = $resolvedTarget
    }
}

Write-Host ''
Write-Host 'Yo Skills installed and verified.' -ForegroundColor Green
$results | Format-Table -AutoSize
Write-Host "Backup: $backupRoot"
Write-Host 'Start a fresh host session to reload its skill catalog.'
