# Validation record

Date: 2026-08-15

Scope: the 19 live `skills/yo-*` trees, their dated pre-rewrite archives, root
bundle metadata and documentation, and the optional Claude SessionStart hooks.

## Research gate

- Every skill has a research or sources reference inside its own tree.
- The live trees contain 275 per-skill unique source-link entries, representing
  218 unique URLs across the bundle.
- Sources favor platform contracts, standards, official engineering guidance,
  and peer-reviewed or controlled research. Each skill's reference file records
  how those sources changed the operating rules rather than serving as a generic
  reading list.
- `yo-workflow` was specifically rebuilt around task-graph-aware orchestration,
  immutable review snapshots, system and coverage maps, independent evidence-
  grounded challenge, explicit unresolved states, centralized synthesis, and a
  completeness pass.
- The 2026-08-08 Golden Engineering Standard is mapped to primary Google,
  Microsoft, Anthropic, OpenAI, and Meta engineering sources. It distinguishes
  minimum necessary complexity from raw line minimization and preserves the
  correctness, security, data, compatibility, reliability, and evidence floor.

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

- Golden Engineering Standard: 8/8 raw solution-shape scenarios passed with
  expected assertions withheld. The initial blind run exposed one audit-severity
  weakness: material needless architecture was identified but not approval-
  blocking. After tightening that evidence-based boundary, two new fresh
  contexts reran all eight cases; G7 correctly returned `FAIL — Major`. Agents
  otherwise chose direct CLI, local-state UI, focused parser, and local-test
  solutions without speculative frameworks while retaining justified provider
  contracts, mixed-version migration safety, and shared tenant-authorization
  policy boundaries.
- Golden-standard behavioral snapshot before the orchestration follow-up: base
  `c317ec4786c225037038c15ca5231c1db5341a0e`, with live `skills/` + `hooks/`
  SHA-256 tree digest
  `e2ce07c2344674bf2a6d1d2626c0de83475ce691638f1772fa2c9b2bc41b5b97`.
  Tests ran in fresh Codex desktop contexts on local macOS with no hook for
  G1-G8; the runtime did not expose a stable model identifier. Hypothetical
  project implementations and commands remained intentionally unavailable.

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
- Daily-work engineering benchmark: 31/31 backend, frontend, difficult
  full-stack, GCP/AWS network/DevOps, and multi-provider platform cases were
  executed and independently scored on seven weighted metrics. The overall
  score is **9.5/10**: backend 9.7, frontend 9.9, difficult full-stack 9.4,
  cloud/DevOps 9.1, and platform engineering 9.5. Correctness, simplicity,
  causal completeness, verification, risk handling, and scope averaged
  9.6-9.9; subagent/decomposition judgment averaged 6.8.
- The daily-work benchmark found one material operating gap: all difficult
  full-stack, cloud, and platform executors selected no subagents even when
  bounded read-only provider, runtime, workspace, or diagnostic lanes would
  have added leverage under one coordinator. It did not reward agent count or
  parallel writers. The complete runner contract, raw cases, withheld
  assertions, scores, recommended agent shapes, independence corrections, and
  limits are in `validation/daily-work-benchmark.md`.
- The benchmark is bound to base
  `c317ec4786c225037038c15ca5231c1db5341a0e` and the same pre-follow-up
  `skills/` + `hooks/` digest recorded above. Twenty-five execution cases used
  fresh contexts; six used context-separated follow-up turns because the live
  agent-thread limit prevented new contexts. Technical graders did not execute
  the domain they scored, and decomposition received a separate normalized
  grading pass.
- Lightweight-orchestration follow-up: six difficult cases were rerun in fresh
  read-only pre-change and candidate CLI contexts with identical prompts, then
  cross-over graded on task-graph fit, lane contracts, ownership, technical
  quality, and efficiency. Candidate mean was **9.5/10**; the pre-change mean
  was 6.2 with two timeout/incomplete cases, or 8.8 over its four completed
  X/Z controls versus candidate 9.6 on those same cases. Candidate technical
  and safety quality was 10/10 in every case.
- A separate 4/4 regression confirmed that local UI and known-cause defect work
  stayed direct and tightly coupled payment/API work kept one coordinator.
  The lightweight-orchestration candidate is bound to
  `yo-engineering/SKILL.md` SHA-256
  `f73e269d77cb1c46b2ea43f6de9a9c4d149703dd18b8d5aa8e39f55326711d16`
  and live `skills/` + `hooks/` digest
  `37c726018598d3c924e9423f0da4cfa0af496a6f200ff8f749840037964f7704`.
- Runtime efficiency did not improve reliably: one hard pair completed before
  its control cutoff, one was effectively unchanged, and one was 15.8% slower;
  token use rose in both comparable pairs. The update improves execution-shape
  judgment, not the speed of the inherited maximum-reasoning runtime. Full
  timings, token counts, case descriptions, score formula, grader separation,
  and limits are in `validation/daily-work-benchmark.md`.
- Golden Stop Rule: 6/6 fresh-context scenarios passed, covering terminal
  feature/defect completion, PASS-level optional findings, unsafe early stopping
  on a Major authorization gap or failed post-simplification test, bounded
  reopening after invalidated payment evidence, and no unauthorized follow-up
  creation. The pre-change control also chose correctly on four representative
  cases and retained the choice under follow-up pressure, so the update is
  recorded as explicit reinforcement against observed multi-day workflow drift,
  not a reproduced single-turn regression.
- Task Authority Boundary: 8/8 fresh-context scenarios passed. Unrelated broad-
  suite failures, nearby TODOs, and unresumed prior tasks remained outside the
  active task without becoming baselines, ledger rows, routes, risks, or follow-
  ups. A required unrelated gate failure correctly blocked a merge-ready claim
  and asked before remediation. Positive controls still honored an explicitly
  requested repository baseline, an Admin-wide audit, a demonstrated same-cause
  authorization path, and explicitly resumed work.
- The retained results used four fresh read-only Codex CLI contexts with
  expected assertions withheld. They are bound to base
  `de333a64fb9ef209d461dbd7e2e8500f7c132c99` and final live `skills/` +
  `hooks/` digest
  `427f9a5db558c3a57bbf363a03708dc2554b97d0b352f868fc4432cbc6f0bc4e`.
  Runtime was Codex CLI `0.147.0-alpha.6.5`, `gpt-5.6-sol`, maximum reasoning,
  approval `never`, read-only sandbox, and no hook. One earlier C1-C2 process
  was excluded because its final output was not retained; a new fresh context
  reran those cases and supplied the counted result.
- The Golden Stop candidate is bound to base
  `81512395c77102fc79d1ce116fb5854f98e37fcf`,
  `yo-engineering/SKILL.md` SHA-256
  `8f1a0e22d31c454639fa988f8e8420e21509e682d23cccb3322fb9c6981f4a21`,
  and live `skills/` + `hooks/` digest
  `1835da4c9b16990ae0031d98e87f646bce40fabf4be337e561491557f2d85d87`.
- Balanced GitHub issue authoring: 5/5 final fresh-context cases passed across a
  small frontend task, an unresolved backend API contract, a difficult
  full-stack feature, a production cross-cloud network change, and a
  multi-provider platform capability. Final independent grader means were 9.1,
  8.5, 9.1-9.6, 9.0, and 9.25; the cross-case mean was approximately **9.1/10**.
- The forward test was allowed to fail visibly. The first candidate left two
  redundant sections on the small task, lacked a decision exit contract, and
  inferred destructive provider policy from available deletion APIs and hooks.
  Those cases received `REVISE`; targeted rule changes and fresh reruns then
  passed. The final suite is bound to base
  `ff6de5ca784b6957a998bb832cdc50341e25adbe`, `yo-gh-write/SKILL.md`
  SHA-256 `582e2c66aa40bf0aac2bd2e342568b6e18aeecd32485cec21bb38020ca2a9d25`,
  and live `skills/` + `hooks/` digest
  `f9a26131cdefbb122cbfe374b85b91f1b413d4180f8d55b4b0a885c80bda5f2a`.
- Golden execution continuity: 31/31 final evidence-bound daily-work cases passed
  across backend, frontend, difficult full-stack, GCP/AWS network/DevOps, and
  multi-provider platform work. The weighted mean was **9.78/10**: backend 9.71,
  frontend 9.96, difficult full-stack 9.70, cloud/DevOps 9.87, and platform
  engineering 9.57. Every raw assertion and hard gate passed; a separate
  termination-only challenger also returned 31/31 with every T score at least 9.
- The evidence is bound to base `2153e01d7bf961eaff56531dd32e2c1bbecab3e5`
  and final live `skills/` + `hooks/` digest
  `ab69c97ffa154f550df22c7f1bfe56a32d4ab2769d6c3eee7f8f170e768cc01c`.
  Five fresh read-only Codex CLI contexts ran all 31 cases at predecessor digest
  `89fb8db374a0a8ce17568d4846baec6f0ea9919e60ccb721d172c557202edfa6`.
  A final incident-stop clarification changed only `yo-incident`; one sixth
  fresh context reran the affected PE1 case at the final digest and passed at
  9.00. The other 30 content-bound results remained applicable. All executors
  used `gpt-5.6-sol` with maximum reasoning and no hook; expected assertions
  were withheld. Earlier failures, targeted reruns, grader-independence
  corrections, the full score table, and design-level limitations are preserved in
  `validation/daily-work-benchmark.md`.

## Optional hook gate

- The Bash hook passes `bash -n` and emits parseable SessionStart JSON.
- The PowerShell hook passed parser validation in the 2026-07-14 lifecycle run.
  PowerShell was unavailable after the 2026-08-08 payload edit; the current
  PowerShell string was extracted and confirmed identical to the parseable Bash
  payload, but this is not mislabeled as a new PowerShell parser pass.
- The payload contains no fixed model, effort, context-window, tool, or
  instruction-discovery assumption. It points to the live skill bodies as the
  authority.
- The payload keeps work inside the current request, accepted clarifications,
  explicitly resumed work, and required proof; ambient failures and prior tasks
  do not become baselines or follow-up work.
- The canonical payload names the Golden Engineering Standard and says clear
  low-risk work bypasses `yo-flow`; it contains no blanket rule routing every
  fix through `yo-verify-premise` or another full workflow.
- A fresh 2026-08-08 hook-loaded daily scenario still bypassed routing for a
  clear low-risk typo after the Golden Engineering Standard was added to the
  payload. It ran against the pre-follow-up `skills/` + `hooks/` digest recorded
  in the behavioral gate.

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

### 2026-08-08 Golden Engineering Standard rerun

- The unchanged Bash installer copied the upgraded 19-skill bundle and both
  optional hooks into a fresh isolated home for Codex, Claude, and shared-agent
  targets; the independent verifier reported 19/19 skills per target and 2/2
  hooks.
- The real user-global skill directories were not used as the test target.
- `install.sh`, `verify.sh`, and the Bash hook pass `bash -n`; the Bash hook
  emits parseable SessionStart JSON. PowerShell was unavailable for a new parser
  run, so the Bash and PowerShell payload strings were extracted and confirmed
  identical while the earlier full PowerShell lifecycle evidence remains
  recorded above.

## 2026-08-09 upgrade checks

- Official skill-creator `quick_validate.py`: 19/19 pass, run unchanged in an
  ephemeral `uv` environment because the system Python lacked PyYAML.
- `agents/openai.yaml`: 19/19 parse, description-length, and `$skill-name`
  default-prompt checks pass.
- Manifest parses and exactly matches the 19 live skill directories.
- 53 local Markdown links were resolved with zero broken targets.
- Backtick-referenced support files exist; all live `SKILL.md` files remain
  under 500 lines (maximum 295); `git diff --check` passes.

## 2026-08-12 `yo-gh-write` balance checks

- Official skill-creator `quick_validate.py` passes for the changed skill in an
  ephemeral `uv` environment with PyYAML.
- All ten newly added primary or first-party research URLs returned HTTP 200 at
  validation time.
- The fresh-context authoring and independent grading contract, raw scenarios,
  initial failures, reruns, scores, and exact snapshot binding are recorded in
  `validation/behavior-scenarios.md`.

## 2026-08-12 execution-continuity checks

- Official skill-creator `quick_validate.py`: 19/19 pass in an ephemeral `uv`
  environment with PyYAML.
- The 19 frontmatter and `agents/openai.yaml` records parse and match their skill
  directories; the bundle manifest parses and matches all 19 live skills.
- Local Markdown links, strict UTF-8/mojibake checks, Bash installer/verifier and
  hook syntax, SessionStart hook JSON, and `git diff --check` pass.
- The Bash and PowerShell hook payloads are text-identical. PowerShell is not
  installed on this macOS host, so no new PowerShell parser pass is claimed.
- The live research corpus contains 275 per-skill unique source entries and 218
  bundle-unique URLs. Every live `SKILL.md` remains below 500 lines; maximum is
  391 (`yo-design`).
- All 31 source URLs added by this change resolved at validation time: 30
  returned HTTP 200 to `curl`; the remaining official OpenAI page rejected the
  command-line client with 403 but loaded through an independent web fetch.
- The five full-suite executor transcripts contain all 31 endpoints and the
  final PE1 delta transcript contains its affected endpoint. They remain within
  their prompt word bounds, read no prohibited skill body or validation source,
  and preserve the digest bindings recorded above.
- The unchanged Bash installer copied the candidate into a new isolated macOS
  home; independent verification reported 19/19 matching skills for both Codex
  and Claude. Optional hooks were not installed.

## 2026-08-15 task-authority checks

- Official skill-creator `quick_validate.py` passes 19/19 skill trees in an
  ephemeral `uv` environment with PyYAML.
- All 19 frontmatter and `agents/openai.yaml` records parse and match their
  directories; the manifest parses, declares revision `2026-08-15`, and exactly
  matches the 19 live skills.
- All 54 local Markdown links and 56 explicit live support-file references
  resolve. Strict UTF-8 and mojibake checks pass across 96 live skill and hook
  files. Every live `SKILL.md` remains below 500 lines; maximum is 391
  (`yo-design`).
- The research corpus remains 275 per-skill unique source entries and 218
  bundle-unique URLs; this update adds no external source URL.
- The Bash hook passes `bash -n` and emits parseable SessionStart JSON. The Bash
  and PowerShell `additionalContext` strings are text-identical. PowerShell is
  unavailable on this host, so no new PowerShell parser pass is claimed.
- `install.sh`, `verify.sh`, and the Bash hook pass `bash -n`; the repository
  passes `git diff --check`.
- The final candidate is bound to base
  `de333a64fb9ef209d461dbd7e2e8500f7c132c99` and live `skills/` + `hooks/`
  digest
  `427f9a5db558c3a57bbf363a03708dc2554b97d0b352f868fc4432cbc6f0bc4e`.

## Limits

- Structural validation proves package shape, not behavioral correctness; the
  scenario tests and source-backed decision records cover that separate risk.
- Fresh scenario agents made read-only decisions; they did not edit hypothetical
  repositories or execute those hypothetical project test commands.
- Daily-work benchmark scores measure design and routing judgment. They do not
  prove implementation fidelity, provider behavior, runtime performance, or
  live cloud state. The original 2026-08-08 suite carries a six-case follow-up-
  context limitation; all final 2026-08-12 executors used fresh CLI contexts.
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
