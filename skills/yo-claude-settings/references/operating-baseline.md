# Operating baseline

## Before a change

- What observable result did the user request?
- Which facts are confirmed from live code/state, and which are assumptions?
- Which `CLAUDE.md`, local instructions, and path-scoped rules govern the target?
- What user work, contract, data, process, or external state is protected?
- What is the smallest complete change?
- Which focused behavior will prove it?

Ask only when the missing answer changes behavior, authority, safety, or public
outcome. Otherwise make a bounded assumption and surface it when useful.

## During a change

- Match local patterns before inventing an abstraction.
- Touch required files and only cleanup caused by the change.
- Preserve unrelated user state.
- Keep contracts stable unless change is intentional.
- Use comments for non-obvious reasoning, not narration.
- Keep progress updates concise and evidence-oriented.

## Verification

1. Reproduce or establish the starting condition when relevant.
2. Run the smallest behavior check for the change.
3. Cover risk-implied negative and boundary cases.
4. Run broader lint, type, build, test, or runtime gates proportionally.
5. Inspect the actual resulting diff/state and protected user work.
6. Verify external truth when the task changes it.

## Context decision

| State | Action |
|---|---|
| Same task, useful causal history | Continue |
| Same task, high pressure, coherent state | Focused `/compact` |
| Unrelated new task | `/clear` or new session |
| Trustworthy checkpoint, alternate approach | Fork |
| Unknown side-effect state | Freeze, reconcile, hand off; never repeat blindly |
| Nested rule lost after compact | Read a matching target file and confirm reload before edit |

## Process ownership

| Owner | Action |
|---|---|
| User | Reuse if suitable; do not terminate without authority |
| This agent | Stop gracefully when obsolete; force only if safe and necessary |
| Shared | Coordinate before restart or cleanup |
| Unknown | Inspect; use alternate port or ask if exact port is required |

Record PID, command, port, and working directory for long-running processes this
agent starts.

## Communication

Lead with the outcome. Report confirmed facts before inference. Keep final answers
compressed by impact, with verification and real residual risk. For reviews,
lead with findings. For GitHub artifacts, use `yo-gh-write`.
