# Validation record

Date: 2026-07-14

Scope: the 19 live `skills/yo-*` trees, their dated pre-rewrite archives, root
bundle metadata and documentation, and the optional Claude SessionStart hooks.

## Research gate

- Every skill has a research or sources reference inside its own tree.
- The live trees contain 217 per-skill unique source-link entries, representing
  172 unique URLs across the bundle.
- Sources favor platform contracts, standards, official engineering guidance,
  and peer-reviewed or controlled research. Each skill's reference file records
  how those sources changed the operating rules rather than serving as a generic
  reading list.
- `yo-workflow` was specifically rebuilt around task-graph-aware orchestration,
  immutable review snapshots, system and coverage maps, independent evidence-
  grounded challenge, explicit unresolved states, centralized synthesis, and a
  completeness pass.

## Artifact and structure gate

| Check | Result |
|---|---|
| Declared skills equal live skill directories | 19/19 pass |
| Dated archive exists for each live skill | 19/19 pass |
| Archive trees byte-match their pre-rewrite source trees | 19/19 pass |
| Live `SKILL.md` differs from its archived predecessor | 19/19 pass |
| Skill-creator structural validator | 19/19 pass |
| Frontmatter `name` equals directory name | 19/19 pass |
| `agents/openai.yaml` present | 19/19 pass |
| Research/sources reference present | 19/19 pass |
| Backtick-referenced local support files exist | pass |
| Manifest parses and matches disk | pass |
| Strict UTF-8 and mojibake scan | pass |
| Required non-Yo skill dependencies | none |

## Behavioral gate

Fresh-context agents tested each rewrite against concrete scenarios rather than
merely restating the skill. The rerunnable inputs and expected assertions are in
`validation/behavior-scenarios.md`. The most risk-sensitive matrices included:

- `yo-workflow`: 9/9 deep-review scenarios passed, including sequential versus
  parallel selection, challenger independence, unresolved evidence, coverage,
  and read-only handoff.
- `yo-codex`: 6/6 delegation scenarios passed, including unavailable MCP tools,
  explicit sandboxing from `--yolo`, overlapping writers, timeout recovery, and
  revision-pinned review.
- `yo-codex-settings`: 6/6 session-baseline scenarios passed.
- `yo-claude-settings`: 6/6 session-baseline scenarios passed, including
  environment-over-effort precedence, managed-policy fallback, compaction reload,
  unknown migration state, and user-owned process safety.
- Bundle integration: active incidents preempt deep-review ceremony; confirmed
  deep-review findings cross a read-only-to-mutation boundary before remediation;
  and a one-line documentation fix routes directly without broad gates.
- Daily coding integration: 10/10 fresh-context scenarios passed. The suite now
  covers a direct S0 correction, a deterministic known-cause bug, unknown-cause
  debugging, a tiny authorization/data change, a contained capability, an
  existing red gate, a missing faithful test seam, an intermittent concurrency
  failure, the canonical hook context, and a high-risk idempotency/retry
  regression claim.
- The daily suite confirmed both sides of the intended boundary: a clear bug can
  use a focused regression and implementation without a RED-only campaign,
  while high-risk closure claims still require pre-fix sensitivity evidence.
  Each scenario used a separate fresh Codex subagent with the expected result
  withheld; the stable model identifier was not exposed by the runtime.
- After the cold audit tightened the bounded-file fast-lane criterion, D1, D2,
  and D5 were rerun in separate fresh contexts against the revised skill text;
  all three retained the intended direct-doc, compact-bug, and feature routes.

## Optional hook gate

- The Bash hook passes `bash -n` and emits parseable SessionStart JSON.
- The PowerShell hook passes parser validation and emits the same parseable
  SessionStart JSON.
- The payload contains no fixed model, effort, context-window, tool, or
  instruction-discovery assumption. It points to the live skill bodies as the
  authority.
- The canonical payload names the risk-based direct lane and proportionate
  inline premise check; it contains no blanket rule routing every fix through
  `yo-verify-premise`.
- A fresh hook-loaded daily scenario still bypassed routing for a clear low-risk
  typo.

## Repository installer gate

Date: 2026-07-11

- `install.ps1` and `verify.ps1` pass PowerShell parser validation.
- `install.sh` and `verify.sh` pass `bash -n`.
- PowerShell and Bash were each tested in a fresh isolated home containing
  Codex, Claude, and shared-agent targets.
- For each platform, the first install replaced one old Yo skill per target,
  installed and verified 19/19 skills, and preserved an unrelated custom skill.
- Re-running each installer replaced and backed up 19/19 skills per target; the
  independent verification command again reported 19/19 exact matches.
- Both test flows created two distinct timestamped backups and left the real
  user-global skill directories untouched.

### 2026-07-14 optional-hook lifecycle rerun

- PowerShell and Bash installer/parser gates passed after adding explicit
  `-InstallClaudeHook` / `--install-claude-hook` options and matching opt-in
  verification flags.
- Each platform was tested in a new isolated home with Codex, Claude, and shared
  targets plus unrelated custom skills and two divergent pre-existing hooks.
- First install backed up and replaced both hooks, installed 19/19 skills per
  target, preserved unrelated skills, and reported 2/2 hook matches.
- A deliberate post-install hook mutation made both verifiers fail; reinstall
  restored exact repository bytes. A second install created a distinct backup
  and again passed 19/19 plus 2/2 verification.
- A separate default install without the hook flag left an existing divergent
  hook byte-for-byte unchanged. Neither installer edits `settings.json`.
- An adversarial Bash lifecycle check started with both managed hook names as
  symlinks to files outside the selected home. Installation moved the link
  entries into backup without changing the external files, installed regular
  verified hook files, and the verifier later rejected a same-content symlink.

## Limits

- Structural validation proves package shape, not behavioral correctness; the
  scenario tests and source-backed decision records cover that separate risk.
- Fresh scenario agents made read-only decisions; they did not edit hypothetical
  repositories or execute those hypothetical project test commands.
- External documentation and platform capabilities can change after this date.
  Platform skills therefore require live capability and configuration checks.
- Hook installation and verification are opt-in because an existing hook is
  user-global state. The default installer continues to manage only skill
  directories.
- Raw agent transcripts are not bundled; the scenario matrix preserves the
  inputs, evaluation contract, and dispositions needed for a clean rerun.
- PSScriptAnalyzer and ShellCheck were not installed in this environment; the
  recorded PowerShell parser, `bash -n`, lifecycle, hash, rollback, and
  adversarial symlink checks are the available script evidence.
