# Delegation contract and handoff templates

Use the smallest template that preserves scope, authority, ownership, and proof.
Remove empty fields rather than sending placeholders.

## Start contract

```markdown
## Objective
<One observable outcome and why this delegated lane exists.>

## Working state
- Workspace: <absolute path>
- Repository/project: <identity>
- Source: <exact SHA, diff, artifact, or input snapshot>
- Review base, if relevant: <exact ref/SHA>
- Existing user work: <protected paths or hunks>

## Scope and ownership
- You own: <paths/components/questions>
- You may read: <supporting scope>
- Do not touch: <paths, shared state, external systems>
- Non-goals: <explicit exclusions>

## Authority
- Allowed: <read, local edits, local commands, named external action>
- Not allowed: <commit, push, post, deploy, secrets, destructive action, etc.>
- Sandbox/network posture: <effective, verified controls>

## Constraints
- Applicable instructions: <AGENTS.md or project rules already discoverable>
- Technical/product constraints: <only material constraints>
- Preserve: <compatibility, API, data, user behavior>

## Acceptance and evidence
- <behavior or finding criterion>
- Run: <focused checks>
- Return: changed files/findings, commands with outcomes, unresolved risk, and
  current state. Do not claim checks you did not run.

## Stop and escalate
- Stop before: <scope expansion or irreversible boundary>
- Ask when: <material decision or authority is missing>
- If blocked: report exact blocker, evidence gathered, partial work, and safest
  next action. Do not improvise around the boundary.
```

## Verification follow-up

````markdown
Independent verification found a failure attributable to this lane.

Command: `<exact command>`
Exit code: `<code>`
Expected: <observable behavior>
Observed: <observable behavior>
Relevant output:

```text
<minimal unedited output>
```

Inspect the current workspace before editing because partial work already exists.
Fix only the attributable failure, preserve protected user work, rerun the
focused check, and report the new result. Stop if the repair crosses your scope.
````

## Unknown-state recovery follow-up

```markdown
The previous response was lost or timed out. Do not repeat the task yet.

Reconcile the current workspace and your session history against the original
contract. Report:

1. actions definitely completed;
2. files or external state currently changed;
3. commands still running or whose outcome is unknown;
4. remaining work;
5. safest resumable next action.

Make no additional mutation until that inventory is complete.
```

## Worker return shape

```markdown
Outcome: <complete | partial | blocked | no finding>

Changed or found:
- <path/symbol or evidence-backed finding>

Verification:
- `<command>` -> <exit/result>

Not done / unresolved:
- <honest remainder or risk>

Current state:
- <workspace and any external state changed>
```

## Controller closeout

The controlling agent records:

- surface, version/schema, and thread/session ID;
- source and workspace identity;
- worker-owned scope and actual resulting diff/findings;
- independent verification performed after the worker returned;
- protected user work check;
- external actions, if any;
- residual risk and next owner.
