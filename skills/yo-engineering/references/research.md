# Research and decisions

Use this file when maintaining or auditing `yo-engineering`. It maps important
rules to authoritative evidence and distinguishes evidence from bundle policy.

## Evidence-to-rule map

| Engineering rule | Evidence | Decision |
|---|---|---|
| Use the lightest process that covers actual risk | OpenAI describes frictionless low-risk actions and explicit review for higher-risk actions; Google review guidance balances progress with code health. | Preserve calibrated tiers and remove ceremony from S0 work. |
| Prefer small, self-contained, reversible changes | Google Engineering Practices and DORA connect smaller changes with better review, lower bug risk, easier rollback, throughput, and stability. Neither provides a universal size threshold. | Keep slicing; remove the one-week and line-count decision rules. |
| Review the whole system through matching expertise | Google review guidance covers design, functionality, complexity, tests, context, and qualified review for specialist risks. | Replace named external reviewer skills with inline risk lenses. |
| Treat security as part of the development lifecycle | NIST SSDF integrates secure practices into each SDLC and targets both vulnerability impact and root causes. | Keep security/privacy as a first-class lens rather than a late audit. |
| Preserve compatibility across more than compilation | Google AIP-180 distinguishes source, wire, and semantic compatibility and warns that apparently additive changes can still break clients. | Make compatibility explicit in the brief and contract lens. |
| Select tests by behavior, speed, and determinism | Software Engineering at Google separates test size from scope and recommends the smallest test that proves the behavior while retaining boundary coverage where needed. | Avoid a unit-test-only rule; require the smallest sufficient evidence. |
| Stage and observe production changes | Google SRE recommends progressive, supervised rollouts, user-centered signals, and rollback before diagnosis when unexpected behavior appears. | Require rollout, observation, pause, and rollback for operational risk. |
| Balance delivery speed with stability | DORA measures both throughput and instability and warns against single-metric targets. | Keep speed plus stability as the outcome; do not optimize one metric in isolation. |
| Preserve behavior while removing measured render work | React defines `useMemo` by its complete dependency list and frames it as a performance optimization; Profiler measures render commits. | Pair profiler/call-count evidence with visible-result checks for unchanged inputs and correct recomputation when every real dependency changes. |
| Preserve meaningful human control | OpenAI's Codex safety practice makes high-risk actions explicit while allowing routine work to proceed. | Keep S3 authorization, but recognize specific authorization already present in the request. |
| Keep discovered work outside the active task | OpenAI's scoped-task and human-control guidance, Google's self-contained-change guidance, and Anthropic's stop-or-ask guidance distinguish evidence gathering from authority to act. | Treat only the current request, accepted clarification, explicitly resumed work, and necessary proof as task authority; ambient findings remain outside scope unless the user expands it. |
| Maximize quality with minimum necessary complexity | Google review and SRE guidance challenge unnecessary complexity; Microsoft emphasizes high-quality incremental outcomes and reducing non-value work; Anthropic starts with the simplest effective pattern; OpenAI describes the smallest tested fix. | Add the Golden Engineering Standard, an evidence-based complexity budget, and a mandatory final simplification pass. |
| Fix causes and realistic same-cause paths | Meta describes root-cause analysis as the basis for fixing recurring defects; OpenAI describes reproducing, fixing, and validating scoped changes. | Require causal correction, focused regression proof, relevant sibling coverage, and no unrelated cleanup. |
| Match execution shape to the task graph | Google Research reports gains on parallelizable tasks and degradation on sequential tasks; Anthropic recommends simple composable workflows and centralized orchestration for independent breadth; OpenAI recommends bounded read-heavy subagents and warns about coordination cost. | Default to one coordinator; use a small set of decision-relevant read-only lanes only for independent questions; centralize the invariant, synthesis, writes, and final claim. |
| Stop when the defined outcome is proven | Google review guidance balances progress with code health; Microsoft prioritizes the definition of done and reducing non-value work; Anthropic warns that extra agentic complexity must justify its cost. | Make completion terminal when acceptance and required evidence pass with no blocking finding; keep optional improvements outside the implementation loop. |
| Preserve execution continuity across handoffs | OpenAI describes handoffs as transferring current conversation state, recommends explicit exit conditions, and warns that more agents add overhead; Microsoft makes completion project-specific through an agreed definition of done. | Carry the lane, decisions, authorization, and valid evidence forward; reopen only affected work when content or material state changes. |
| Use only endpoint-owning workflows | The same OpenAI handoff guidance and Anthropic simplicity guidance make extra routing worthwhile only when a distinct specialist decision is needed. | Let normal implementation own known fixes, configuration corrections, and refactors; reserve `yo-feature` for capabilities and `yo-design` for a requested or genuinely unresolved design decision. |
| Prove concurrent derived state across meaningful orders | The bundle's existing concurrency evidence requires deterministic interleavings and invariant assertions rather than timing luck. | Test bounded materially distinct schedule/failure classes and the boundaries that can change the outcome; do not inflate this into a Cartesian replay of every permutation. |
| Close stateful integration lifecycles | The bundle's existing contract, data, reliability, and external-boundary sources require explicit ownership, idempotency, mixed-state safety, reconciliation, rollback, and faithful provider evidence. | Bind stateful cursors to their query meaning; use one migration runner; rehearse infrastructure-state recovery; and for multi-provider flows name field authority, stable identity mapping, ownership-safe compensation, reconciliation, contract tests, and secret hygiene. |
| Preserve identity and ordering at stateful boundaries | PostgreSQL documents how multicolumn B-tree order must match requested ordering; AWS documents transactional outbox atomicity, duplicate-safe consumers, and notification order; OpenID Connect defines issuer plus subject as the stable identity and rejects email as a unique identifier; S3 gives each object version a distinct version ID and recommends granular least privilege. | Require query-plan/index proof for keyset paths, stable outbox identity and aggregate order, safe federated account linking, and exact-version/least-privilege quarantine lifecycles only when those surfaces are touched. |
| Close historical and governed-data lifecycles | Stripe documents duplicate webhook delivery and durable event-ID deduplication; the NIST Privacy Framework requires an inventory of systems/owners across the data lifecycle and policy-driven deletion; GDPR requires purpose limitation, data minimization, storage limitation, accountability, and notices to processors holding copies. | Before a uniqueness migration, resolve existing duplicate identities/effects; for erasure, snapshot mandatory participants, require durable acknowledgements, and isolate lawfully retained records behind their own purpose, owner, access, and retention boundary. |
| Keep tenant authority server-derived across execution paths | OWASP requires default-deny authorization on every request, recommends centralized decisions, and its multi-tenant guidance derives tenant context from verified identity while enforcing isolation at the data layer. | Treat request/message/job tenant IDs as claims; make API and workers use one policy boundary backed by trusted identity or persisted ownership, fail closed, and test cross-tenant negatives. |
| Keep small interactive controls semantically complete | W3C's button and switch patterns require an accessible name, exposed binary state, and keyboard activation. | A local reveal/toggle stays a direct local change, but its focused proof covers name, state, keyboard activation, and lifecycle reset without introducing shared state. |
| Decide consistency tradeoffs before architecture | Meaningful human-control and definition-of-done guidance require material owner choices to be explicit without repeating settled work. | Never infer zero RPO for collaborative multi-region state; decide merge semantics, acknowledged-edit RPO/RTO, and failover authority once, then resume implementation. |

## Authoritative sources

- Google Engineering Practices, [Small CLs](https://google.github.io/eng-practices/review/developer/small-cls.html)
- Google Engineering Practices, [The Standard of Code Review](https://google.github.io/eng-practices/review/reviewer/standard.html)
- Google Engineering Practices, [What to look for in a code review](https://google.github.io/eng-practices/review/reviewer/looking-for.html)
- DORA, [Software delivery performance metrics](https://dora.dev/guides/dora-metrics/)
- NIST, [Secure Software Development Framework SP 800-218](https://csrc.nist.gov/pubs/sp/800/218/final)
- Google, [AIP-180: Backwards compatibility](https://google.aip.dev/180)
- Software Engineering at Google, [Testing Overview](https://abseil.io/resources/swe-book/html/ch11.html)
- Google SRE, [Production Services Best Practices](https://sre.google/sre-book/service-best-practices/)
- OpenAI, [Running Codex safely at OpenAI](https://openai.com/index/running-codex-safely/)
- Google SRE, [Simplicity](https://sre.google/sre-book/simplicity/)
- Google SRE Workbook, [Simplicity](https://sre.google/workbook/simplicity/)
- Microsoft, [Code With Engineering Playbook](https://microsoft.github.io/code-with-engineering-playbook/)
- Microsoft, [Developer Experience](https://microsoft.github.io/code-with-engineering-playbook/developer-experience/)
- Microsoft, [Definition of Done](https://microsoft.github.io/code-with-engineering-playbook/agile-development/team-agreements/definition-of-done/)
- Anthropic, [Building effective agents](https://www.anthropic.com/engineering/building-effective-agents)
- OpenAI, [Engineering solutions](https://openai.com/business/solutions/engineering/)
- OpenAI, [How OpenAI uses Codex](https://cdn.openai.com/pdf/6a2631dc-783e-479b-b1a4-af0cfbd38630/how-openai-uses-codex.pdf)
- Meta Engineering, [Minesweeper root cause analysis](https://engineering.fb.com/2021/02/09/developer-tools/minesweeper/)
- Google Research, [Towards a science of scaling agent systems](https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/)
- Anthropic, [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system)
- OpenAI, [A practical guide to building agents](https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/)
- OpenAI, [Codex subagents](https://developers.openai.com/codex/subagents)
- Martin Fowler, [Feature Toggles](https://martinfowler.com/articles/feature-toggles.html) — delivery-pattern details, not the risk taxonomy.
- PostgreSQL, [Indexes and `ORDER BY`](https://www.postgresql.org/docs/current/indexes-ordering.html)
- AWS Prescriptive Guidance, [Transactional outbox pattern](https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/transactional-outbox.html)
- OpenID Foundation, [OpenID Connect Core 1.0 — Claim Stability and Uniqueness](https://openid.net/specs/openid-connect-core-1_0.html#ClaimStability)
- Google Identity, [OpenID Connect API reference](https://developers.google.com/identity/openid-connect/reference)
- Amazon S3, [How S3 Versioning works](https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html)
- Amazon S3, [Managing access with S3 Access Grants](https://docs.aws.amazon.com/AmazonS3/latest/userguide/access-grants.html)
- Stripe, [Receive events in your webhook endpoint — duplicate events](https://docs.stripe.com/webhooks#handle-duplicate-events)
- NIST, [Privacy Framework 1.0](https://www.nist.gov/document/nist-privacy-frameworkv10pdf)
- European Union, [General Data Protection Regulation, Articles 5 and 17](https://eur-lex.europa.eu/eli/reg/2016/679/oj)
- OWASP, [Authorization Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authorization_Cheat_Sheet.html)
- OWASP, [Multi-Tenant Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Multi_Tenant_Security_Cheat_Sheet.html)
- W3C WAI-ARIA APG, [Button Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/button/)
- W3C WAI-ARIA APG, [Switch Pattern](https://www.w3.org/WAI/ARIA/apg/patterns/switch/)

## Keep / improve / move / remove

### Keep

- A compact senior gate centered on outcome, invariants, failure, compatibility,
  rollback, slicing, and evidence.
- The S0–S3 calibration and explicit control of irreversible actions.
- Small reversible delivery, meaningful tests, fresh verification, and measured
  performance work.
- Immediate incident preemption and downstream Yo handoffs.
- One accountable coordinator and no agent fan-out for tightly coupled work.

### Improve

- Label S0–S3 as a local Yo convention rather than an external standard.
- Count clear authorization already present instead of prompting twice.
- Apply risk lenses inline and record their closing evidence.
- Treat graceful degradation and small adjacent cleanup with context rather than
  absolute prohibitions.
- Define compatibility as source, wire, semantic, and persisted-data behavior.
- Make execution shape explicit in the engineering brief: direct by default,
  bounded read-only lanes for independent decision-relevant questions, isolated
  writers only with an integration contract, and central synthesis.
- Make the verified definition of done terminal; reopen only the smallest scope
  invalidated by new material evidence.
- For a known tenant-claim defect, repair current execution-time authorization
  without inventing an alternate grant-semantics decision absent a real contract.

### Move

- Move detailed risk questions to `risk-lenses.md`.
- Move flags, abstractions, migrations, canaries, and other staging options to
  `delivery-patterns.md`.
- Leave downstream implementation mechanics in their owning Yo skills.
- Leave Codex session mechanics in `yo-codex`, deep-review orchestration in
  `yo-workflow`, and incident roles/mutations in `yo-incident`.

### Remove

- Remove all required or optional non-Yo skill names.
- Remove duplicated descriptions of every downstream workflow.
- Remove the approximate one-week branch threshold and implied universal line
  limits.
- Remove the absolute ban on combining any refactor with behavior change.
- Remove the claim that `yo-impact` alone mechanically answers every risk class.

## Classification notes

- Small batches, compatibility analysis, secure development, staged rollout,
  and evidence selection are research-backed engineering practices.
- S0–S3 names and the bundle-only boundary are local Yo policy.
- The user's current request can provide authorization; whether it is specific
  enough is a live-context judgment.
- Repository instructions and actual deployment capabilities override generic
  delivery patterns.
