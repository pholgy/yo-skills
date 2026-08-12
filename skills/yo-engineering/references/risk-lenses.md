# Engineering risk lenses

Apply only the lenses triggered by the touched surface. For each selected lens,
record the key invariant, likely failure, and evidence that closes the risk.

| Lens | Trigger | Questions to answer | Strong evidence |
|---|---|---|---|
| Contract and compatibility | HTTP/RPC/GraphQL APIs, SDKs, CLI flags, events, webhooks, file formats | Who consumes it? What changes in source, wire, semantic, error, ordering, or default behavior? Can old and new versions coexist? If a cursor or token carries state, does it bind every query dimension that affects its meaning or reject a mismatch while preserving issued-token behavior? Does keyset pagination have an index whose leading equality dimensions and complete ordered tuple match each supported query direction? | Consumer/contract tests, old/new fixture matrix, schema diff, compatibility or deprecation plan, representative query-plan proof |
| Data and migration | Schema, backfill, index, retention, cache format, destructive rewrite | Which store/service is authoritative through expansion, cutover, and rollback? What invariant protects each row/object? Is there one migration owner/runner? Is the operation online, lock-bounded, restartable, idempotent, observable, and reversible? How are old shapes handled and how is recovery rehearsed before contraction? | Production-scale rehearsal, lock/latency measurements, reconciliation query, checkpoints, rollback rehearsal |
| Security and privacy | Authn/authz, tenant boundaries, secrets, untrusted input, sensitive data, policy | What is the trust boundary and attacker capability? Is authorization checked at the resource? What data can leak, persist, or enter logs? For federated identity, are Authorization Code + PKCE, issuer/audience/signature/expiry, redirect URI, state, and nonce validated; how are immutable issuer/subject identities linked without collision, account takeover, unsafe relinking, or email-only trust; and how is enforcement staged and rolled back? For secret metadata UI, can the requested metadata be shown without ever rendering, returning, persisting, or logging the secret value? | Negative authorization, protocol, and account-linking tests; old/new session/client enforcement matrix; threat cases; secret/log scan; audit trail; security control verification |
| Concurrency and distributed state | Async work, streams, queues, retries, cancellation, shared state, transactions | Who owns authoritative and visible state? Which transitions are monotonic or version-guarded? What ordering is required? Are retries idempotent? When a database decision causes asynchronous or external side effects, is durable outbox intent committed with it, with a stable event ID and required per-aggregate sequence? What happens on duplication, partial failure, cancellation, stale work, or several pending intents settling in another order? Can every visible cache projection, including list and detail views, be recomputed from the authoritative base plus the intents still pending instead of restoring a stale snapshot? For an operation stream, where is the authoritative revisioned log, how are missing revisions detected/recovered, and when is an operation acknowledged? For multi-region state, what explicit RPO/RTO and failover authority apply even if the merge algorithm is unchanged? | Bounded materially distinct interleaving/failure classes with invariant or property assertions—not a Cartesian replay of every permutation; idempotency and outbox-order test; failure injection; cache-projection reconciliation; gap/replay recovery; race-aware trace; failover/recovery exercise |
| Reliability and operability | Production boundary, background job, integration, deployment, fallback | How does it fail? Which user signal detects it? Can rollout pause and roll back? For a network path, are bidirectional routing, stateful inspection symmetry, capacity, denial paths, failover, and failback explicit? Are logs, metrics, traces, and alerts actionable? | Representative canary, positive and negative path probes, capacity/failover/failback exercise, dashboard/trace, rollback test, user-visible verification |
| User experience and accessibility | UI, workflow, error state, interaction, metadata | Does the user understand state, progress, failure, and recovery? Is keyboard, focus, contrast, semantics, and responsive behavior preserved? | Browser flow, accessibility check, screenshots where visual state matters, error/recovery exercise |
| Maintainability and domain model | New abstraction, type/schema, ownership boundary, complex logic | Does the design match the codebase? Which invalid states remain representable? Is responsibility clear? Is complexity justified by a current need? | Focused design review, type/schema examples, tests of invariants, simpler alternative comparison |
| Performance and capacity | Latency, memory, throughput, bundle size, query/load optimization | What measured bottleneck matters to users or capacity? Is the comparison workload identical? What tradeoff moved elsewhere? Does the optimized path preserve the visible/domain result for unchanged inputs and recompute correctly when real dependencies change? | Reproducible before/after benchmark or profile paired with a behavioral oracle; changed-dependency result check; load test, resource and tail-latency comparison when material |
| Dependency and supply chain | New or upgraded package, runtime, service, toolchain | Is it necessary, maintained, licensed appropriately, secure, and affordable to operate? What transitive surface and upgrade path arrive with it? | Route to `yo-deps`; record provenance, dependency graph, advisory status, compatibility tests |
| External platform integration | Several SaaS/BaaS providers or control planes participate in one lifecycle | Which system owns each field and identity? How are stable identities mapped? Does a durable inbox enforce a unique provider/event admission key, and are side effects idempotent? Can lookup, retry, and compensation prove resource ownership before mutation? How are drift and partial failure reconciled, provider contracts verified, and secrets excluded from logs? | Field-authority and identity map, durable-inbox uniqueness proof, provider contract/sandbox tests, duplicate/reorder/failure injection, ownership-safe compensation, reconciliation run, secret/log scan |

For quarantined object ingestion, carry the exact immutable object identity
(bucket, key, version/generation, and checksum when available) through upload,
scan, promotion, download authorization, and cleanup. Separate uploader, scanner,
promoter, downloader, and reconciler permissions to their least-privilege
actions. A logical key or latest-version lookup is not sufficient evidence that
the scanned bytes are the downloaded or deleted bytes.

When an external event influences authorization or entitlement, the
notification is evidence to reconcile—not authority to grant access by arrival
alone. Project from the current authoritative provider/domain state, make
transitions monotonic or version-guarded, and require the authorization path to
consult authoritative state so a stale or missing cache can never elevate
access.

For tenant-isolated operations, treat a tenant identifier carried by a request,
message, or job as an untrusted claim rather than authority. Both the synchronous
API path and every asynchronous worker must call the same policy boundary,
derive tenant and resource ownership from authenticated server context or a
trusted persisted relationship, and fail closed when that relationship is
missing or conflicts. Prove both paths with cross-tenant negative tests; data-
layer scoping or row-level security is defense in depth, not a replacement for
the shared decision.

Those negative tests permit the minimum trusted ownership/policy lookup needed
to decide. Assert zero unauthorized or cross-tenant disclosure, mutation, or
external side effect—not zero reads of any kind, which would contradict server-
side authorization itself. Instrument or scope the data layer so the lookup
cannot return another tenant's protected data before the policy decision.

For collaborative state spanning regions, do not derive `RPO 0` from words such
as loss, replay, or convergence. The owner must choose merge/conflict semantics,
the RPO for acknowledged edits, RTO, and failover authority before an
architecture commits to synchronous cross-region acknowledgement, a single
regional writer, or a lossy availability tradeoff. Present the consequence of
each viable option and stop at that decision; after acceptance, carry it into
implementation without another discovery pass.

When the demonstrated defect is that an asynchronous path trusts a carried
tenant claim, the default correction is to re-derive and authorize against
current trusted state at execution. Do not invent a blocking product decision
between execution-time authority and a hypothetical persisted enqueue-time
grant. Consider the latter only when an existing accepted contract explicitly
requires enqueue-time authority to survive later revocation; then the grant must
be server-created, scoped, immutable, expiring, and independently authorized.

## Lens selection rules

- Select by affected behavior, not by file extension.
- Combine lenses when one change crosses boundaries; a webhook migration can
  require contract, data, security, concurrency, and operability analysis.
- Do not claim a lens is closed because a generic test suite is green. Match the
  evidence to the failure named by that lens.
- If the needed evidence cannot be produced before release, state the residual
  risk and require an explicit decision at the correct tier.
