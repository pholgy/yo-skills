# Operating baseline

These are the user's durable engineering preferences, expressed without disputed
attribution or a stale model/version dependency.

## Before a change

- What observable result did the user request?
- What facts are confirmed from live code/state, and what is assumed?
- Which instruction files govern the target path?
- Which repository verification contract applies to this target or subproject:
  focused tests, lint, typecheck, build, and their CI equivalents?
- What user work, public contract, data, process, or external state is protected?
- What is the smallest complete change?
- Which focused check will fail before or prove after the change?

Discover the applicable verification contract before the first edit in each
target scope; do not assume one command covers an entire monorepo. When current
health or change attribution matters, run the smallest relevant existing check
before editing and record its result. Do not require a full suite as ritual for
a documentation-only or otherwise unobserved low-risk change; state what was
inspected or why no useful pre-edit gate exists.

Ask only when a missing answer materially changes behavior, authority, safety, or
public outcome. Otherwise make a bounded assumption and state it when useful.

## During a change

- Match local patterns before inventing an abstraction.
- Touch only required files and directly caused cleanup.
- Preserve unrelated user changes and generated/source boundaries.
- Keep behavior and public contracts stable unless change is intentional.
- Add comments only for non-obvious reasoning, not narration.
- Keep the user informed with concise, outcome-oriented updates during tool work.

## Verification ladder

1. Reproduce or establish the starting condition when relevant.
2. Run the smallest behavior check for the change.
3. Test negative and boundary cases implied by the risk.
4. Run broader lint, type, build, or test gates in proportion to impact.
5. Inspect the actual resulting diff/state and protected user work.
6. Verify external/runtime truth when the task changes it.

Do not claim a check passed if it was skipped, stale, run against another
revision, or failed for an unresolved reason.

## Communication

Intermediate update:

```text
<What is now known>. <What is being checked or changed next>.
```

Final handoff:

```text
<Outcome first>.

<Material change or decision, compressed by impact rather than file inventory.>

Verification: <commands/behavior and result>. <Real residual risk, if any>.
```

For reviews, lead with evidence-backed findings. For GitHub artifacts, use
`yo-gh-write`. For complex implementation standards, use `yo-engineering` only
when its trigger fits; this baseline does not force every skill into every task.

## Process ownership

| Process state | Default action |
|---|---|
| Confirmed user-owned | Reuse if suitable; never terminate without authority |
| Confirmed agent-owned and obsolete | Stop gracefully; force only if needed and safe |
| Unknown owner | Inspect; use alternate port or ask if exact port is required |
| Shared test dependency | Coordinate ownership and lifecycle before restart |
| Timed-out process | Treat outcome/state as unknown; inspect before retry |

Record PID, command, port, and cwd for every long-running process the agent starts.
