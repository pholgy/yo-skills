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
| Preserve meaningful human control | OpenAI's Codex safety practice makes high-risk actions explicit while allowing routine work to proceed. | Keep S3 authorization, but recognize specific authorization already present in the request. |
| Maximize quality with minimum necessary complexity | Google review and SRE guidance challenge unnecessary complexity; Microsoft emphasizes high-quality incremental outcomes and reducing non-value work; Anthropic starts with the simplest effective pattern; OpenAI describes the smallest tested fix. | Add the Golden Engineering Standard, an evidence-based complexity budget, and a mandatory final simplification pass. |
| Fix causes and realistic same-cause paths | Meta describes root-cause analysis as the basis for fixing recurring defects; OpenAI describes reproducing, fixing, and validating scoped changes. | Require causal correction, focused regression proof, relevant sibling coverage, and no unrelated cleanup. |
| Match execution shape to the task graph | Google Research reports gains on parallelizable tasks and degradation on sequential tasks; Anthropic recommends simple composable workflows and centralized orchestration for independent breadth; OpenAI recommends bounded read-heavy subagents and warns about coordination cost. | Default to one coordinator; use a small set of decision-relevant read-only lanes only for independent questions; centralize the invariant, synthesis, writes, and final claim. |
| Stop when the defined outcome is proven | Google review guidance balances progress with code health; Microsoft prioritizes the definition of done and reducing non-value work; Anthropic warns that extra agentic complexity must justify its cost. | Make completion terminal when acceptance and required evidence pass with no blocking finding; keep optional improvements outside the implementation loop. |

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
- Anthropic, [Building effective agents](https://www.anthropic.com/engineering/building-effective-agents)
- OpenAI, [Engineering solutions](https://openai.com/business/solutions/engineering/)
- OpenAI, [How OpenAI uses Codex](https://cdn.openai.com/pdf/6a2631dc-783e-479b-b1a4-af0cfbd38630/how-openai-uses-codex.pdf)
- Meta Engineering, [Minesweeper root cause analysis](https://engineering.fb.com/2021/02/09/developer-tools/minesweeper/)
- Google Research, [Towards a science of scaling agent systems](https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/)
- Anthropic, [How we built our multi-agent research system](https://www.anthropic.com/engineering/multi-agent-research-system)
- OpenAI, [A practical guide to building agents](https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/)
- OpenAI, [Codex subagents](https://developers.openai.com/codex/subagents)
- Martin Fowler, [Feature Toggles](https://martinfowler.com/articles/feature-toggles.html) — delivery-pattern details, not the risk taxonomy.

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
