# Orchestration architecture

## Choose from the task graph

| Task property | Preferred shape | Why |
|---|---|---|
| One coupled path, shared mutable state, sequential dependencies | Sequential single context | Preserves the causal chain and avoids coordination loss. |
| Independent flows or stable risk questions | Parallel sectioning with central synthesis | Gains breadth/latency without splitting one invariant. |
| Unknown partitions emerge during exploration | Central orchestrator-workers | Lets one owner adapt the map and prevent gaps/duplication. |
| Material candidate needs stronger confidence | Fresh challenger/evaluator | Adds technical independence and an opposing hypothesis. |
| Simple bounded review | One reviewer/pass | Multi-agent overhead has no demonstrated value. |

Tool count, context overlap, and cross-worker dependencies increase coordination cost. When most work requires the same context or each step depends on the previous result, keep it sequential even if many files are involved.

## Central coordinator responsibilities

The coordinator is the only owner of:

- immutable snapshot and environment assumptions;
- system map, risk matrix, exclusions, and effort budget;
- non-overlapping worker contracts;
- candidate identity and provenance;
- retries, failed workers, and blocked coverage;
- challenge assignment and independence disclosure;
- deduplication, severity, final evidence check, and report.

Workers do not publish, edit, merge, create issues, or coordinate external actions. They may discover new boundaries; they return those to the coordinator instead of silently expanding scope.

## Worker contract

Every delegated pass specifies:

1. one objective and why it is separable;
2. exact revision and available environment evidence;
3. entry point, terminal boundary, and relevant invariants;
4. files/components that are context, not the entire scope;
5. excluded work owned by another pass;
6. allowed read-only tools and prohibited side effects;
7. candidate and coverage output schema;
8. a stop condition and how to report blockage.

Vague prompts create duplicated searches and invisible gaps. A worker should be able to state exactly which coverage-matrix cells it owns.

## Technical independence levels

- **Same-pass check:** useful for obvious consistency, not independent verification.
- **Separate opposing pass:** finder deliberately re-derives the claim from raw evidence; some context anchoring remains.
- **Fresh-context challenge:** reviewer receives the scoped claim and evidence but not the proposed fix or desired verdict.
- **Qualified independent review:** appropriate human/domain owner with relevant authority and expertise.

Report the level actually achieved. This workflow can improve technical independence; it does not claim NASA-style managerial or financial IV&V.

## Coordination failure modes and controls

| Failure mode | Control |
|---|---|
| Duplicate workers, missed boundaries | Shared map plus distinct ownership contracts |
| Finder conclusion copied as fact | Preserve raw evidence; challenger reopens code/runtime proof |
| Majority amplifies the same error | Central evidence adjudication, not voting |
| One worker hides blocked evidence | Mandatory unknowns and coverage status |
| Context compression loses location/provenance | Stable candidate IDs, exact file/line, snapshot, and evidence |
| Moving branch invalidates results | Resolve immutable SHAs and reconfirm before synthesis |
| Tool or worker failure appears as clean coverage | Mark the cell blocked/partial and report it |
| Agent count grows without value | Add work only for a distinct, material coverage gap |

## Adaptive effort

Begin with the map and one capable reviewer. Add parallel workers when partitions are independent, an orchestrator when partitions are dynamic, and a fresh challenger when candidate risk or ambiguity justifies it. Stop adding coordination when marginal passes repeat covered work, require the same context, or cannot change the decision.

When Claude needs Codex workers, use `yo-codex` for the actual session/tool contract. Do not duplicate model names, shell commands, sandbox flags, or concurrency limits here.
