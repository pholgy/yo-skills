# Daily-work engineering benchmark

Date: 2026-08-08

The 31-case result below is the pre-orchestration benchmark. The authorized
2026-08-09 lightweight-orchestration change and its blind cross-over follow-up
are recorded at the end of this file.

This benchmark tests whether the Yo bundle produces the smallest complete,
production-quality engineering response across realistic daily work. It also
tests whether subagents are used for leverage rather than ceremony.

## Result

| Measure | Score |
|---|---:|
| Overall weighted score | **9.5/10** |
| Correctness and acceptance fit | 9.9 |
| Simplicity and minimum necessary complexity | 9.6 |
| Causal completeness and sibling-path coverage | 9.8 |
| Verification and evidence quality | 9.8 |
| Security, compatibility, data, and operational risk | 9.9 |
| Subagent and decomposition judgment | **6.8** |
| Scope, authority, and communication | 9.9 |

The bundle's engineering decisions are consistently direct, explainable, and
production-safe. The material gap is under-delegation: executors correctly
avoided parallel writers and needless agent fan-out, but they also returned
`Subagents: None` for every difficult full-stack, cloud, and platform case.
Twenty-one cases had a useful bounded read-only decomposition that was not
selected. The quality standard is strong; the delegation decision is not yet
surfacing reliably during broad implementation, incident, and integration work.

No scoring cap was triggered. These are design-level scores, not claims that
hypothetical code or cloud changes were executed.

## Tested snapshot

- Base `HEAD`: `c317ec4786c225037038c15ca5231c1db5341a0e`
- Live `skills/` + `hooks/` SHA-256 tree digest:
  `e2ce07c2344674bf2a6d1d2626c0de83475ce691638f1772fa2c9b2bc41b5b97`
- Host/runtime: Codex desktop on local macOS; the runtime did not expose a
  stable model identifier.
- Hook state: not loaded.
- Environment: read-only decisions against hypothetical repositories and cloud
  estates. No project files, provider accounts, deployments, or destructive
  operations were available or authorized.

## Method

The suite contains 31 raw daily-job scenarios:

- 6 backend;
- 6 frontend;
- 9 difficult multi-stack full-stack;
- 7 GCP/AWS network and DevOps; and
- 3 platform-engineering scenarios spanning several SaaS or BaaS providers.

Executors received the raw task and current `yo-*` skills, but not the
acceptance checks or grading rubric. They were prohibited from reading this
repository's validation artifacts, editing files, or touching external
systems. Each response had to provide its route, proposed change or design,
verification, risks, subagent shape, and authority boundary.

Twenty-five cases ran in fresh executor contexts. The live agent-thread limit
required DO5-DO7 and PE1-PE3 to run as context-separated follow-up turns. This
is weaker than a fresh context and is recorded as a limitation rather than
described as equivalent.

Technical grading used a separate target-domain non-executor. One initial
DevOps grade overlapped with the executor of DO5-DO7 and was discarded; the
recorded DevOps technical scores come from a new non-executor grading turn. A
separate decomposition-only pass normalized subagent scores across all cases.
BE and PE delegation scores received an additional non-executor check because
the first normalization agent had executed cases in those domains. The root
coordinator applied the published formula and caps; no vote or self-review was
treated as proof.

## Scoring contract

Each metric is scored from 1 to 10.

| Code | Metric | Weight |
|---|---|---:|
| C | Correctness and acceptance fit | 20% |
| S | Simplicity, leverage, and minimum necessary complexity | 20% |
| K | Causal completeness, root cause, and relevant sibling paths | 15% |
| V | Verification and evidence quality | 15% |
| R | Security, compatibility, data, and operational risk | 15% |
| A | Subagent and decomposition judgment | 10% |
| Q | Scope, authority, and communication | 5% |

`Overall = 0.20C + 0.20S + 0.15K + 0.15V + 0.15R + 0.10A + 0.05Q`,
rounded half-up to one decimal.

For A, more agents never means a higher score by itself. A 10 means the shape
matches the task graph: one agent for simple or tightly coupled work; bounded
read-only lanes for genuinely independent discovery, provider, runtime, or
compatibility surfaces; isolated non-overlapping writers only when necessary;
and one coordinator owning the shared invariant, authority, synthesis, and
final verification.

The following caps apply:

- incorrect, unsafe, destructive, or falsely verified work: overall at most 5;
- a missing critical invariant or speculative architecture: overall at most 6;
- a defect response without root cause and regression protection: at most 6;
- an active incident that is not incident-first: at most 4;
- unsafe parallel writers or a delegated product decision: material deduction;
- cloud mutation without exact target, rollback, and authority: risk cap.

The rubric follows the bundle's
[Golden Engineering Standard](../skills/yo-engineering/references/quality-standard.md),
the task-graph evidence in
[`yo-workflow`](../skills/yo-workflow/references/sources.md), and OpenAI's
bounded read-heavy subagent guidance recorded in
[`yo-codex`](../skills/yo-codex/references/sources.md).

## Raw cases and withheld acceptance checks

The checks in this section were withheld from executor agents and disclosed
only to graders.

### Backend

| ID | Raw daily job | Required assertions |
|---|---|---|
| BE1 | Node/TypeScript consumes at-least-once provider webhooks; concurrent duplicates create duplicate ledger rows and email, and `provider_event_id` is not unique. | Make event admission atomic at PostgreSQL with a unique key; keep ledger and outbox intent in one transaction; cover concurrency, crash windows, sink idempotency, and historical data. |
| BE2 | Add status filtering and ascending/descending order to a Go orders endpoint whose cursor is `(created_at,id)`; preserve default behavior and issued cursors. | Preserve the omitted/default path; bind or reject filter/direction mismatches; retain legacy cursor behavior; use correct tuple predicates, indexes, and contract tests. |
| BE3 | A Python GraphQL `Order.customer` resolver has a measured N+1; a DataLoader exists elsewhere; authorization and null behavior must not change. | Use request-scoped batching without cross-tenant leakage; retain authorization, ordering, null, and error semantics; prove a bounded query count. |
| BE4 | A Spring service commits PostgreSQL and then publishes Kafka; a crash between them loses events. | Use a transactional outbox, idempotent consumers, stable ordering, duplicate-safe delivery, and failure injection; never claim exactly once. |
| BE5 | A Ruby multi-tenant API authorizes requests, but a background worker trusts `tenant_id` from the job payload. | Derive tenant from trusted server state in both paths; fail closed; share the policy boundary; add negative tests and defense in depth. |
| BE6 | Checkout retries a timed-out payment with a new key and can double-charge. | Persist one attempt and reuse the provider key across timeout, crash, and concurrency; represent unknown outcomes, reconcile, and prove one charge. |

### Frontend

| ID | Raw daily job | Required assertions |
|---|---|---|
| FE1 | Add a Show API-key metadata toggle to one React settings card; no persistence is requested. | Keep state component-local, initially hidden and reset on remount; use the accessible local pattern; never expose or persist the secret. |
| FE2 | Vue search results sometimes show an older request after a newer one. | Enforce latest-request-wins for success, error, loading, clear, and repeated queries; use deterministic deferred-promise tests. |
| FE3 | A profiled Next.js page recomputes grouping for 10,000 products on every unrelated keystroke. | Memoize at the measured owner seam with stable inputs; avoid a cache framework or unrelated optimization; remeasure and protect behavior. |
| FE4 | A custom `div` modal has broken keyboard and focus behavior; the design system already has a Dialog primitive. | Replace only the shell with the established primitive; preserve behavior and layout; test name, focus, Tab, Escape, close paths, and restoration. |
| FE5 | React Query optimistic renames can let an older failed mutation roll back a newer success. | Sequence per-entity operations, remove only the settling intent, recompute visible state, reconcile list/detail caches, and deterministically test every ordering. |
| FE6 | Put exactly three Angular table filters in the URL; the team may add fifteen someday. | Make the URL canonical for the three typed keys, preserve unrelated parameters and history, normalize safely, and build no speculative filter framework. |

### Difficult full-stack

| ID | Raw daily job | Required assertions |
|---|---|---|
| FS1 | React, API, worker, PostgreSQL, Redis lock, and payment provider can create duplicate orders and charges when the lock expires. | Put durable idempotency in the database/provider boundary, use an outbox, keep Redis non-authoritative, and cover concurrent and crash boundaries. |
| FS2 | A legal deletion flow spans UI, API, PostgreSQL, Kafka, Python workers, email, S3 versions, and backups; PII must go in 30 days while billing stays seven years. | Use an idempotent erasure saga, registered acknowledgements, every object version/restore path, deadline evidence, and a separately governed billing store. |
| FS3 | Migrate profile reads from Rails to Kotlin while web and old mobile clients coexist; a new field is incompatible and rollback is required. | Expand-migrate-contract around one authority; preserve v1 behavior, use compatible rollout/shadow evidence, and retain a real rollback floor. |
| FS4 | A collaborative editor spans React, WebSockets, Redis, PostgreSQL, and two regions; replay causes duplicates, reordering, and loss. | Use an authoritative revisioned operation log, stable operation IDs, gap recovery, reconnect state, fencing, and an explicit RPO decision. |
| FS5 | Add OIDC SSO and organization roles across Next.js, Go, mobile, old sessions, and old clients supported for 60 days. | Preserve compatible app sessions, implement PKCE/state/nonce and safe identity linking, centralize roles/revocation, stage enforcement, and define cutoff behavior. |
| FS6 | Presigned S3 uploads feed SQS scanning; files can be downloaded before scanning and failures leave orphans. | Use a fail-closed, exact-version quarantine lifecycle, idempotent scanning, authorization on download, reconciliation, lifecycle cleanup, and least privilege. |
| FS7 | Duplicate and out-of-order Stripe events can grant premium after cancellation through Node, PostgreSQL, and Redis. | Never grant from invoice arrival; make entitlement state monotonic and authoritative, reconcile provider state, deduplicate, and ensure cache cannot elevate access. |
| FS8 | Change address text to structured data across React, Go, Python, PostgreSQL, and Kafka while old clients/events remain for two weeks and rollback is required. | Use additive versioned storage/contracts, mixed-version readers and writers, no lossy invented parsing, restartable backfill, reconciliation, and rollback. |
| FS9 | Production is active: Next.js slowed after release, Go CPU is normal, PostgreSQL connections are full, and Redis hit rate collapsed; the team asks for a redesign. | Enter incident mode, freeze and mitigate one hypothesis-backed change, prove recovery, and defer redesign/RCA until stable. |

### GCP, AWS, network, and DevOps

| ID | Raw daily job | Required assertions |
|---|---|---|
| DO1 | Production Cloud Run returns 502 to private Cloud SQL after a VPC/firewall change. | Treat as an incident; discriminate the cause; use a least-privilege reversible mitigation, canary, denial proof, and named production authority. |
| DO2 | Two AWS accounts both use `10.0.0.0/16`; they must connect three services in both directions through a preferred TGW design. | State that ordinary routing cannot solve overlap; use translation/service boundaries or a simpler PrivateLink option; prove symmetry and negative paths. |
| DO3 | Cloud Run inside VPC Service Controls exports a BigQuery aggregate to an external SaaS; the team proposes disabling the perimeter. | Keep VPC-SC; distinguish perimeter policy from external egress; declassify through an approved aggregate, narrow IAM, controlled egress, and audit. |
| DO4 | EKS DNS fails intermittently under load; CoreDNS restarts help briefly. | Discriminate CoreDNS, conntrack, ENI, upstream, and amplification causes before changing anything; repeat equivalent-load and recurrence proof. |
| DO5 | GCP HA VPN to AWS TGW uses BGP and a stateful firewall; maintenance causes asymmetric routing and drops. | Build one bidirectional packet-path model, deterministic failover, symmetric inspection/state handling, drain sequencing, capacity proof, and failback. |
| DO6 | A Terraform shared-network module refactor changes resource addresses across 40 workspaces and may recreate networks. | Inventory every address/object identity, use explicit moves or controlled state migration, require zero destructive actions per workspace, canary, batch, and rehearse rollback. |
| DO7 | A Cloud Run API and ECS worker share a schema during rolling overlap; zero downtime and rollback are required. | Expand-migrate-contract with compatible mixed writers/readers, one migration runner, bounded backfill, lock proof, reconciliation, and a delayed contract step. |

### Platform engineering

| ID | Raw daily job | Required assertions |
|---|---|---|
| PE1 | Okta SCIM deactivates users, Auth0 owns sessions, internal RBAC authorizes, and Slack carries access notifications; deactivated users retain access for hours. | Keep one identity authority, deny internally immediately, revoke vendors asynchronously, use generations/idempotency/reconciliation, and audit the lifecycle. |
| PE2 | Stripe, Salesforce, HubSpot, and internal entitlements drift because webhooks duplicate/reorder and humans edit records. | Define field-level sources of truth, stable identity mapping, an idempotent inbox/current-state reconciliation, deterministic entitlements/outbox, and explicit conflict policy; avoid a generic platform. |
| PE3 | One platform request provisions GitHub, Vercel, Supabase, and Cloudflare; partial failures orphan resources and logs expose credentials. | Use a durable idempotent saga, ownership-safe lookup/compensation, status and reconciliation, provider contract tests, secret-manager references, and log redaction. |

## Per-case scores

| ID | C | S | K | V | R | A | Q | Overall |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| BE1 | 10 | 9 | 10 | 9 | 10 | 10 | 10 | 9.7 |
| BE2 | 10 | 10 | 9 | 10 | 9 | 10 | 10 | 9.7 |
| BE3 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10.0 |
| BE4 | 10 | 9 | 9 | 10 | 10 | 6 | 10 | 9.3 |
| BE5 | 10 | 9 | 10 | 10 | 10 | 8 | 10 | 9.6 |
| BE6 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10.0 |
| FE1 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 9.9 |
| FE2 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10.0 |
| FE3 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 9.9 |
| FE4 | 10 | 10 | 10 | 10 | 10 | 10 | 10 | 10.0 |
| FE5 | 10 | 9 | 10 | 10 | 10 | 10 | 10 | 9.8 |
| FE6 | 10 | 10 | 10 | 9 | 10 | 10 | 10 | 9.9 |
| FS1 | 10 | 10 | 10 | 10 | 10 | 5 | 10 | 9.5 |
| FS2 | 10 | 9 | 10 | 10 | 10 | 4 | 10 | 9.2 |
| FS3 | 10 | 10 | 10 | 10 | 10 | 5 | 10 | 9.5 |
| FS4 | 10 | 9 | 10 | 10 | 10 | 5 | 10 | 9.3 |
| FS5 | 9 | 10 | 9 | 9 | 9 | 5 | 10 | 8.9 |
| FS6 | 10 | 10 | 10 | 10 | 10 | 6 | 10 | 9.6 |
| FS7 | 10 | 10 | 10 | 10 | 10 | 7 | 10 | 9.7 |
| FS8 | 10 | 10 | 10 | 10 | 10 | 4 | 8 | 9.3 |
| FS9 | 10 | 10 | 10 | 10 | 10 | 4 | 10 | 9.4 |
| DO1 | 10 | 9 | 9 | 10 | 10 | 4 | 10 | 9.1 |
| DO2 | 10 | 9 | 9 | 9 | 9 | 5 | 9 | 8.8 |
| DO3 | 9 | 9 | 9 | 10 | 10 | 5 | 10 | 9.0 |
| DO4 | 9 | 10 | 9 | 10 | 9 | 5 | 10 | 9.0 |
| DO5 | 10 | 9 | 10 | 10 | 10 | 4 | 10 | 9.2 |
| DO6 | 10 | 9 | 10 | 10 | 10 | 5 | 10 | 9.3 |
| DO7 | 10 | 9 | 10 | 10 | 10 | 6 | 10 | 9.4 |
| PE1 | 10 | 10 | 10 | 10 | 10 | 6 | 10 | 9.6 |
| PE2 | 10 | 10 | 10 | 10 | 10 | 5 | 10 | 9.5 |
| PE3 | 10 | 9 | 10 | 10 | 10 | 6 | 10 | 9.4 |

### Domain averages

| Domain | Cases | Overall |
|---|---:|---:|
| Backend | 6 | 9.7 |
| Frontend | 6 | 9.9 |
| Difficult full-stack | 9 | 9.4 |
| GCP/AWS network and DevOps | 7 | 9.1 |
| Platform engineering | 3 | 9.5 |

## Better subagent shape by case

All executors chose no subagents except FE5, which requested one final
read-only auditor. The table records the task-graph shape used for the final A
score. It is a recommendation for execution, not permission to mutate several
systems concurrently.

| ID | Proportionate shape |
|---|---|
| BE1 | One coordinator owns the transaction, outbox invariant, migration, and concurrency proof. |
| BE2 | One implementer owns cursor encoding, decoding, compatibility, and focused tests. |
| BE3 | One security-focused implementer owns loader scoping, authorization order, and tenant tests. |
| BE4 | Coordinator owns the outbox invariant; read-only lanes inventory consumers, schemas, and retry contracts. |
| BE5 | Read-only API and worker lanes map authorization; coordinator owns the shared policy change. |
| BE6 | One coordinator validates provider semantics and owns the coupled charge-state invariant. |
| FE1 | One implementer makes and verifies the component-local change. |
| FE2 | One implementer owns request ordering and deterministic race tests. |
| FE3 | One implementer validates the measurement, applies the narrow optimization, and remeasures. |
| FE4 | One implementer follows the Dialog pattern and verifies the whole interaction. |
| FE5 | One writer owns optimistic state; one final read-only auditor challenges races and rollback consistency. |
| FE6 | One implementer owns the exact URL-state contract and three-filter coverage. |
| FS1 | Coordinator owns the order invariant; read-only UI/API, worker/payment, and database/cache lanes map current behavior. |
| FS2 | Coordinator owns legal policy; read-only lanes inventory stores, async consumers, user flow, vendors, and backup limits. |
| FS3 | Coordinator owns compatibility; read-only Rails, Kotlin, and old-client lanes recover current contracts. |
| FS4 | Coordinator owns consistency; read-only regional runtime, Redis, gateway, and PostgreSQL lanes feed one model. |
| FS5 | Coordinator owns authorization; read-only Next, Go, mobile, legacy-client, and IdP lanes map current behavior. |
| FS6 | Coordinator owns the upload lifecycle; read-only storage, scanner, queue, and IAM lanes inspect provider contracts. |
| FS7 | Coordinator owns the entitlement invariant; a provider-contract lane complements the internal state review. |
| FS8 | Coordinator owns migration compatibility; read-only runtime, persisted-data, Kafka, and legacy-consumer lanes map impact. |
| FS9 | Incident commander synthesizes parallel read-only Next, Redis, and PostgreSQL evidence lanes before one mitigation. |
| DO1 | Incident commander owns mitigation; parallel read-only Cloud Run, network, firewall, and Cloud SQL lanes collect evidence. |
| DO2 | Coordinator owns reachability; read-only lanes inventory both VPC/TGW routing domains and security controls. |
| DO3 | Coordinator owns the data boundary; read-only VPC-SC, BigQuery export, and SaaS lanes verify constraints. |
| DO4 | Coordinator owns diagnosis; parallel read-only CoreDNS, node-network, VPC DNS, and load-correlation lanes discriminate cause. |
| DO5 | Coordinator owns failover; read-only GCP, AWS, BGP, and firewall lanes feed one packet-path model. |
| DO6 | Coordinator owns the module contract; read-only workspace lanes inventory variants and plans, then recheck zero destruction centrally. |
| DO7 | Coordinator owns schema compatibility; read-only Cloud Run and ECS lanes map rolling-version overlap. |
| PE1 | Read-only Okta, Auth0, RBAC, and Slack lanes feed one coordinator owning immediate denial and all mutations. |
| PE2 | Read-only provider lanes feed one coordinator owning the source-of-truth matrix, conflicts, and entitlement convergence. |
| PE3 | Read-only provider lanes map idempotency and cleanup; one coordinator owns the saga, rollback, secrets, and sequential mutations. |

## Findings

1. **Small does not mean unsafe.** The answers used local state, established UI
   primitives, direct cursor contracts, transactional outboxes, durable payment
   attempts, monotonic authorization state, and expand-migrate-contract only
   when current requirements justified them.
2. **Defect closure is strong.** Backend and frontend responses consistently
   removed the causal mechanism and proposed deterministic, same-cause
   regression evidence instead of masking symptoms.
3. **Complex systems still remained explainable.** Full-stack and platform
   answers named one authority or invariant and avoided generic frameworks,
   exactly-once claims, Redis-as-truth, and distributed transactions.
4. **Delegation is too conservative.** The model understood safe orchestration
   when asked to grade it, but normal execution responses did not route broad
   S2/S3 work through that decision. This is an invocation/discoverability gap,
   not a reason to mandate agents by count.
5. **Cloud answers need slightly more specificity.** DO2-DO4 lost technical
   points where topology, traffic shape, provider behavior, or causal selection
   remained conditional. They still stopped safely rather than inventing live
   facts.
6. **The lowest case was still sound.** DO2 scored 8.8 because the final network
   shape still depended on traffic-specific topology and provider details, and
   the two-account surface was not decomposed. It still correctly rejected
   ordinary routing across overlapping CIDRs and stopped before unsafe changes.

## Limits

- This tests routing and design judgment, not implementation fidelity or actual
  runtime performance.
- No hypothetical repository, provider contract, production trace, Terraform
  plan, schema, or cloud account was available; verification scores assess the
  proposed evidence, not observed evidence.
- Six execution cases used context-separated follow-up turns because the live
  agent limit prevented new threads. Grading separation reduces but does not
  erase that limitation.
- Raw agent transcripts are not bundled. This file preserves the snapshot,
  runner contract, raw scenarios, withheld assertions, scores, and
  dispositions needed for a clean rerun.
- Scores contain expert judgment. The formula, caps, technical/delegation
  separation, and dissent recheck make that judgment inspectable rather than
  pretending it is an objective runtime measurement.
- This original run predates the separately authorized orchestration update.
  Its gap and score remain unchanged as baseline evidence; the follow-up below
  records the changed behavior rather than rewriting the original result.

## 2026-08-09 lightweight-orchestration follow-up

The update makes execution shape an inline engineering decision. It defaults to
one coordinator and permits a small number of bounded, decision-relevant lanes
only when they can progress independently, carry explicit stop conditions, and
be reconciled by one owner. Stack, file, service, provider, and severity counts
do not justify delegation. Coupled changes keep one writer.

### Bound snapshots

| Snapshot | `yo-engineering/SKILL.md` SHA-256 | `yo-engineering/references/research.md` SHA-256 | `skills/` + `hooks/` tree digest |
|---|---|---|---|
| A — pre-change control | `de9d6412dcfde5a59d3baf36217cfc6c640d76ba64aafa06d8577c5549570206` | `6fe422b456fc980688d1f499d673901e36ac95d72e4ace8f6f2d6ac2b7cb59a2` | `e2ce07c2344674bf2a6d1d2626c0de83475ce691638f1772fa2c9b2bc41b5b97` |
| B — candidate | `f73e269d77cb1c46b2ea43f6de9a9c4d149703dd18b8d5aa8e39f55326711d16` | `2c94538e592a773b0be53b9ac74f926b3ad73772b8d3a7256dd769aea4451e62` | `37c726018598d3c924e9423f0da4cfa0af496a6f200ff8f749840037964f7704` |

Both snapshots use base `HEAD`
`c317ec4786c225037038c15ca5231c1db5341a0e`. The tree digest is SHA-256
over the sorted per-file SHA-256 records for regular files under `skills/` and
`hooks/`.

### Runner and scoring contract

Six difficult cases ran twice with identical prompts: retail failover and
cross-system access termination (X1-X2), a live cross-cloud incident and a
60-cluster schema migration (Y1-Y2), and multi-SaaS convergence plus a
mixed-version tax-identifier rollout (Z1-Z2). Four additional cases checked
that a local React toggle, a known parser defect, a payment idempotency fix, and
a Go cursor-contract extension did not trigger needless fan-out (L1-L4).

- Each A/B group used a fresh, read-only Codex CLI session. Runtime was
  `codex-cli 0.147.0-alpha.6.5`, inherited `gpt-5.6-sol` with maximum reasoning,
  approval `never`, no hook, and no model override. No repository, provider, or
  production mutation was permitted.
- Cross-over graders did not grade the group they executed. They scored task-
  graph fit (T), lane-contract quality (L), ownership and synthesis (O),
  technical and safety quality (Q), and execution efficiency (E).
- `Overall = 0.30T + 0.20L + 0.20O + 0.20Q + 0.10E`, rounded to one decimal.
  More agents earned no credit by themselves.
- An initially reused agent-thread control was discarded because prior
  benchmark context contaminated it. Only the fresh CLI controls below count.

### Blind cross-over result

| Case | A | B | Material result |
|---|---:|---:|---|
| X1 — regional retail failover | 8.5 | **9.4** | B found three independent read-only questions while retaining one no-oversell owner and writer. |
| X2 — access termination | **9.5** | 9.4 | Both found the right graph; B's clearer lane contracts did not repay its runtime cost. |
| Y1 — active GKE/AWS incident | 1.0 | **9.3** | A produced no final before cutoff; B kept incident command and serialized mutations. |
| Y2 — 60-cluster migration | 1.0 | **9.3** | A produced no final before cutoff; B separated read-only discovery from one migration writer. |
| Z1 — multi-SaaS convergence | 8.6 | **9.8** | B used contract-shaped rather than provider-shaped lanes and centralized authority. |
| Z2 — mixed-version rollout | 8.7 | **9.8** | B used client/API, data, and event-contract lanes with one canonical owner. |
| **Mean** | **6.2** | **9.5** | A is penalized for two incomplete cases; over only completed X/Z controls, A is 8.8 and B is 9.6. |

Candidate B retained a Q score of 10/10 in all six cases. Its gains came from
better task-graph selection, bounded lane contracts, and central ownership—not
from parallel writers or delegation by count.

### Speed and efficiency

| Pair | A elapsed / tokens | B elapsed / tokens | Interpretation |
|---|---:|---:|---|
| X1-X2 | 362.67 s / 68,884 | 420.02 s / 111,763 | B was 57.35 s slower and used 42,879 more tokens. |
| Y1-Y2 | >370 s / unavailable | 278.31 s / 74,830 | B completed 91.69 s before A's cutoff; A had no gradeable final. |
| Z1-Z2 | 348.09 s / 43,932 | 346.62 s / 47,651 | B was 1.47 s faster but used 3,719 more tokens. |
| L1-L4 candidate regression | n/a | 272.06 s / 50,508 | 4/4 execution decisions passed, but the run remained slow. |

The speed result is mixed, not a demonstrated runtime improvement. The change
improves orchestration choice and completion on the tested hard cases, while
maximum-reasoning search remains the dominant cost and candidate token use rose
in both comparable pairs. The skill therefore requires the decision inline in
one sentence and forbids a separate orchestration-planning phase, but it does
not claim to make the underlying model faster.

The lightweight regression passed 4/4: L1 and L2 stayed direct; L3 and L4 kept
one coordinator because their payment and cursor invariants were tightly
coupled. A later independent read-only audit was allowed as verification and
was not counted as implementation fan-out.

### Follow-up limits

- These are read-only decision outputs, not implemented systems or measured
  production outcomes.
- Aggregate pair timings cannot attribute cost to an individual case or to the
  orchestration text alone. A's Y token total is unavailable because the
  process was stopped after the time limit without a final response.
- The CLI emitted unrelated credential-refresh warnings; it used no external
  tools, and those warnings were not treated as case evidence.
- Scores remain expert judgments under the published rubric. Snapshot hashes,
  matched prompts, blind execution, and cross-over grading make the comparison
  inspectable and its limitations explicit.
- Full raw follow-up prompts and transcripts are not bundled. The case
  descriptions and runner contract support a clean equivalent rerun, but not a
  byte-for-byte replay.
