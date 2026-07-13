[CmdletBinding()]
param(
    [ValidateSet('auto', 'all', 'codex', 'claude', 'agents')]
    [string[]]$Target = @('auto'),

    [string]$InstallHome = $env:USERPROFILE,

    [switch]$InstallClaudeHook
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

function Assert-FileEqual {
    param(
        [Parameter(Mandatory)][string]$Expected,
        [Parameter(Mandatory)][string]$Actual
    )

    $actualItem = Get-Item -Force -LiteralPath $Actual -ErrorAction SilentlyContinue
    if ($null -eq $actualItem -or $actualItem.PSIsContainer -or
        ($actualItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        throw "Missing installed file: $Actual"
    }

    $expectedHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Expected).Hash
    $actualHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $Actual).Hash
    if ($expectedHash -ne $actualHash) {
        throw "Hash mismatch: $Actual"
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
if ($InstallClaudeHook -and -not $selected.Contains('claude')) {
    throw '-InstallClaudeHook requires claude to be one of the selected targets.'
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

$hookFiles = @()
$stagedHookRoot = Join-Path $backupRoot 'staged-hooks'
if ($InstallClaudeHook) {
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
    New-Item -ItemType Directory -Force -Path $stagedHookRoot | Out-Null
    foreach ($hook in $hookFiles) {
        if (-not (Test-Path -LiteralPath $hook.Source -PathType Leaf)) {
            throw "Missing hook source: $($hook.Source)"
        }
        $stagedHook = Join-Path $stagedHookRoot $hook.Name
        Copy-Item -LiteralPath $hook.Source -Destination $stagedHook -Force
        Assert-FileEqual -Expected $hook.Source -Actual $stagedHook
    }
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
    $touchedSkills = [System.Collections.Generic.List[string]]::new()
    $installHooksForHost = $InstallClaudeHook -and $hostName -eq 'claude'
    $hookTargetRoot = Join-Path $homePath '.claude\hooks'
    $oldHookRoot = Join-Path $backupRoot 'old-claude-hooks'
    $failedHookRoot = Join-Path $backupRoot 'failed-claude-hooks'
    $touchedHooks = [System.Collections.Generic.List[string]]::new()
    $hooksBackedUp = 0

    try {
        foreach ($skill in $sourceSkills) {
            $installedSkill = Join-Path $resolvedTarget $skill.Name
            if (Test-Path -LiteralPath $installedSkill) {
                Move-Item -LiteralPath $installedSkill -Destination (Join-Path $oldRoot $skill.Name)
                $touchedSkills.Add($skill.Name)
                $backedUp++
            }
            else {
                $touchedSkills.Add($skill.Name)
            }

            Copy-Item -LiteralPath (Join-Path $stagedRoot $skill.Name) -Destination $installedSkill -Recurse -Force
        }

        foreach ($skill in $sourceSkills) {
            Assert-TreeEqual -Expected $skill.FullName -Actual (Join-Path $resolvedTarget $skill.Name)
        }

        if ($installHooksForHost) {
            New-Item -ItemType Directory -Force -Path $hookTargetRoot | Out-Null
            $resolvedHookTarget = (Resolve-Path -LiteralPath $hookTargetRoot).Path
            if (-not $resolvedHookTarget.StartsWith($homePrefix, [StringComparison]::OrdinalIgnoreCase)) {
                throw "Refusing to install hooks outside the selected home: $resolvedHookTarget"
            }

            New-Item -ItemType Directory -Force -Path $oldHookRoot | Out-Null
            foreach ($hook in $hookFiles) {
                $installedHook = Join-Path $resolvedHookTarget $hook.Name
                $existingHook = Get-Item -Force -LiteralPath $installedHook -ErrorAction SilentlyContinue
                if ($null -ne $existingHook) {
                    Move-Item -LiteralPath $installedHook -Destination (Join-Path $oldHookRoot $hook.Name)
                    $touchedHooks.Add($hook.Name)
                    $hooksBackedUp++
                }
                else {
                    $touchedHooks.Add($hook.Name)
                }
                Copy-Item -LiteralPath (Join-Path $stagedHookRoot $hook.Name) -Destination $installedHook -Force
            }

            foreach ($hook in $hookFiles) {
                Assert-FileEqual -Expected $hook.Source -Actual (Join-Path $resolvedHookTarget $hook.Name)
            }
        }
    }
    catch {
        New-Item -ItemType Directory -Force -Path $rollbackRoot | Out-Null
        foreach ($skillName in $touchedSkills) {
            $installedSkill = Join-Path $resolvedTarget $skillName
            $oldSkill = Join-Path $oldRoot $skillName
            if (Test-Path -LiteralPath $installedSkill) {
                Move-Item -LiteralPath $installedSkill -Destination (Join-Path $rollbackRoot $skillName)
            }
            if (Test-Path -LiteralPath $oldSkill) {
                Move-Item -LiteralPath $oldSkill -Destination $installedSkill
            }
        }
        if ($touchedHooks.Count -gt 0) {
            New-Item -ItemType Directory -Force -Path $failedHookRoot | Out-Null
            foreach ($hookName in $touchedHooks) {
                $installedHook = Join-Path $hookTargetRoot $hookName
                $oldHook = Join-Path $oldHookRoot $hookName
                if ($null -ne (Get-Item -Force -LiteralPath $installedHook -ErrorAction SilentlyContinue)) {
                    Move-Item -LiteralPath $installedHook -Destination (Join-Path $failedHookRoot $hookName)
                }
                if ($null -ne (Get-Item -Force -LiteralPath $oldHook -ErrorAction SilentlyContinue)) {
                    Move-Item -LiteralPath $oldHook -Destination $installedHook
                }
            }
        }
        throw
    }

    $results += [PSCustomObject]@{
        Host = $hostName
        Skills = $sourceSkills.Count
        Replaced = $backedUp
        HookFiles = $(if ($installHooksForHost) { $hookFiles.Count } else { 0 })
        HooksReplaced = $hooksBackedUp
        Target = $resolvedTarget
    }
}

Write-Host ''
Write-Host 'Yo Skills installed and verified.' -ForegroundColor Green
$results | Format-Table -AutoSize
Write-Host "Backup: $backupRoot"
Write-Host 'Start a fresh host session to reload its skill catalog.'
