# Install the Yo skills bundle

This folder contains 19 self-contained Yo skills. Install the same complete set
for Claude Code, Codex, or both. Platform-specific skills are selected by their
descriptions only when the matching host or delegation workflow applies.

The commands below are backup-first: an existing skill with the same name is
moved to a timestamped backup before the bundled replacement is copied.

## Recommended installer

The repository installers auto-detect existing user-global hosts, stage and
verify the source, preserve same-named skills, install all 19, and verify every
copied file. They perform no network requests and do not modify unrelated skills
or plugins. The default path does not install hooks or edit host settings.

Windows PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

macOS, Linux, or Git Bash:

```bash
chmod +x ./install.sh ./verify.sh
./install.sh
```

Use `-Target all` or `--target all` to install into Codex, Claude Code, and the
shared `~/.agents/skills` location. Use an explicit `codex`, `claude`, or
`agents` target for only one host. Re-running the installer is the update path.

Recommended-installer backups live under
`~/.yo-skills-backups/<timestamp>/`. If a target install fails, the installer
moves the incomplete copy aside and restores the previous skills.

To install the optional Claude SessionStart reminder with the skills, opt in
explicitly:

```powershell
.\install.ps1 -Target claude -InstallClaudeHook
```

```bash
./install.sh --target claude --install-claude-hook
```

The option requires `claude` among the selected targets, stages and verifies
both canonical hook files, and preserves same-named installed hooks under the
same timestamped backup. It never edits `~/.claude/settings.json`.

## Manual: Claude Code on Windows

Run from the folder containing this file:

```powershell
$source = (Resolve-Path .\skills).Path
$target = Join-Path $env:USERPROFILE '.claude\skills'
$backup = Join-Path $env:USERPROFILE ('.claude\skills-backup\' + (Get-Date -Format 'yyyyMMdd-HHmmss'))

New-Item -ItemType Directory -Force -Path $target, $backup | Out-Null

Get-ChildItem -LiteralPath $source -Directory -Filter 'yo-*' | ForEach-Object {
    $installed = Join-Path $target $_.Name
    if (Test-Path -LiteralPath $installed) {
        Move-Item -LiteralPath $installed -Destination (Join-Path $backup $_.Name)
    }
    Copy-Item -LiteralPath $_.FullName -Destination $installed -Recurse
}
```

Invoke `/yo-claude-settings` for the session baseline or `/yo-flow` when the
desired workflow is unclear. Claude Code also discovers matching personal skills
automatically from their descriptions.

## Manual: Codex on Windows

Run from the folder containing this file:

```powershell
$source = (Resolve-Path .\skills).Path
$target = Join-Path $env:USERPROFILE '.codex\skills'
$backup = Join-Path $env:USERPROFILE ('.codex\skills-backup\' + (Get-Date -Format 'yyyyMMdd-HHmmss'))

New-Item -ItemType Directory -Force -Path $target, $backup | Out-Null

Get-ChildItem -LiteralPath $source -Directory -Filter 'yo-*' | ForEach-Object {
    $installed = Join-Path $target $_.Name
    if (Test-Path -LiteralPath $installed) {
        Move-Item -LiteralPath $installed -Destination (Join-Path $backup $_.Name)
    }
    Copy-Item -LiteralPath $_.FullName -Destination $installed -Recurse
}
```

Invoke `$yo-codex-settings` for the session baseline or `$yo-flow` when routing
is genuinely ambiguous.

## Manual: macOS, Linux, or Git Bash

Choose one or both targets, then run the matching block from this folder:

```bash
# Claude Code
target="$HOME/.claude/skills"
backup="$HOME/.claude/skills-backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$target" "$backup"
for skill in "$PWD"/skills/yo-*; do
  name="$(basename "$skill")"
  [ ! -e "$target/$name" ] || mv "$target/$name" "$backup/$name"
  cp -R "$skill" "$target/$name"
done
```

```bash
# Codex
target="$HOME/.codex/skills"
backup="$HOME/.codex/skills-backup/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$target" "$backup"
for skill in "$PWD"/skills/yo-*; do
  name="$(basename "$skill")"
  [ ! -e "$target/$name" ] || mv "$target/$name" "$backup/$name"
  cp -R "$skill" "$target/$name"
done
```

## Verify the install

Recommended full-tree verification:

```powershell
.\verify.ps1
```

```bash
./verify.sh
```

The verification commands compare every file in each selected installed skill
against this repository. Add `-IncludeClaudeHook` or
`--include-claude-hook` with a Claude target to require both installed optional
hook files to byte-match the repository. Hook verification is opt-in so a
default skill-only install does not claim ownership of user-managed hooks.

```powershell
.\verify.ps1 -Target claude -IncludeClaudeHook
```

```bash
./verify.sh --target claude --include-claude-hook
```

The count-only checks below are a manual fallback.

PowerShell:

```powershell
$target = Join-Path $env:USERPROFILE '.codex\skills' # or .claude\skills
$installed = Get-ChildItem -LiteralPath $target -Directory -Filter 'yo-*'
$missingEntrypoints = $installed | Where-Object {
    -not (Test-Path -LiteralPath (Join-Path $_.FullName 'SKILL.md'))
}

$installed.Count       # expected: 19
$missingEntrypoints    # expected: no output
```

Bash:

```bash
target="$HOME/.codex/skills" # or "$HOME/.claude/skills"
find "$target" -mindepth 1 -maxdepth 1 -type d -name 'yo-*' | wc -l # expected: 19
find "$target" -mindepth 2 -maxdepth 2 -type f -name SKILL.md | grep '/yo-' | wc -l # expected: 19
```

Then start or continue the host and invoke its baseline plus the router. Claude
Code watches an existing personal skills directory for `SKILL.md` changes; if
the top-level directory was created during the active session, restart once so
it can be discovered.

## Optional Claude SessionStart reminder

The skills work without a hook. The optional hook adds a short route reminder
at startup, resume, clear, and compaction. It intentionally contains no hardcoded
model, effort, context-window, or instruction-scope values; `yo-claude-settings`
remains the source of truth.

Prefer the opt-in installer commands above: they back up, copy, and verify both
canonical scripts. The installer deliberately leaves `settings.json` alone
because merging a handler is a user-owned configuration decision. The manual
copy steps below are available when only one platform script is wanted.

Copy the appropriate script:

```powershell
$hooks = Join-Path $env:USERPROFILE '.claude\hooks'
New-Item -ItemType Directory -Force -Path $hooks | Out-Null
Copy-Item -LiteralPath .\hooks\yo-claude-baseline.ps1 -Destination $hooks
```

```bash
mkdir -p ~/.claude/hooks
cp ./hooks/yo-claude-baseline.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/yo-claude-baseline.sh
```

Merge one handler into the existing `hooks.SessionStart` array in
`~/.claude/settings.json`; do not replace unrelated settings or hook entries.

Windows PowerShell handler:

```json
{
  "matcher": "startup|resume|clear|compact",
  "hooks": [
    {
      "type": "command",
      "command": "powershell.exe",
      "args": [
        "-NoLogo",
        "-NoProfile",
        "-NonInteractive",
        "-ExecutionPolicy",
        "Bypass",
        "-File",
        "C:/Users/<you>/.claude/hooks/yo-claude-baseline.ps1"
      ],
      "timeout": 10
    }
  ]
}
```

Bash handler:

```json
{
  "matcher": "startup|resume|clear|compact",
  "hooks": [
    {
      "type": "command",
      "command": "/absolute/path/to/.claude/hooks/yo-claude-baseline.sh",
      "args": [],
      "timeout": 10
    }
  ]
}
```

Validate `settings.json` after merging and inspect `/hooks`. The reminder runs
on the next matching SessionStart event. Current Claude Code hook configuration
and output contracts are documented at <https://code.claude.com/docs/en/hooks>;
personal skill discovery is documented at
<https://code.claude.com/docs/en/slash-commands>.

## Restore a previous install

The recommended installer prints its backup path. Previous directories are in
`old-codex-skills`, `old-claude-skills`, or `old-agents-skills` below that path.
Move the current same-named directory aside, then move the desired backup back
into the host's `skills` directory.

The manual commands preserve replaced folders in the per-host `skills-backup`
directory shown in their examples. The bundle's own pre-rewrite snapshots are
also available under `archive/`.

When hook installation was opted in, previous hook files are under
`old-claude-hooks` in the printed backup directory. Move a current managed hook
aside, restore the desired same-named file, and rerun hook-inclusive
verification. Restoring hook files does not modify the handler in
`settings.json`.
