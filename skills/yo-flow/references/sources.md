# Research and decisions

Use this file when maintaining or auditing `yo-flow`. It records which rules are
evidence-backed, which are bundle design choices, and what changed from the
archived version.

## Evidence-to-rule map

| Router rule | Evidence | Decision |
|---|---|---|
| Keep routing simple and use it only for distinct destinations | Anthropic recommends simple, composable agent patterns and describes routing as classification into distinct specialized follow-ups. | Make `yo-flow` a thin router, not an orchestrator or universal wizard. |
| Clarify only when intent is genuinely unclear | Microsoft says disambiguation is useful for unclear requests or similar competing intents, and warns that unnecessary questions feel like interrogation. | Skip questions for clear intent; ask only a destination-changing question. |
| Use targeted options with an escape | Microsoft recommends targeted questions or options and requires a path such as "none of these" when options do not fit. | Offer a short choice set plus free-form response; never make the choices exhaustive. |
| Ask one necessary question at a time | GOV.UK says to ask only for needed information, avoid asking twice, and start with one question per page. | Ask one question per response and carry forward everything already known. |
| Stop repeated fallback loops and preserve context | Microsoft recommends no more than two fallback questions and says a good handoff remembers where the user stopped. | Cap failed clarification attempts at two and pass context into the destination. |
| Ask the user only for choices they must own | Anthropic distinguishes gaps an agent can resolve from preference or intent questions only the user can settle, while warning against both constant interruption and blindly pushing through. | Inspect or infer reversible details; ask directly for material preference, intent, or approval. |
| Preempt normal routing during active incidents | Google SRE prioritizes structured incident response, early declaration, mitigation, communication, and control. | Route live production impact immediately to `yo-incident`. |
| Keep operational detail outside the main skill | The Agent Skills specification recommends progressive disclosure, focused references, and one-level-deep links. | Keep the procedure in `SKILL.md`; move the route catalog and question examples to references. |

## Authoritative sources

- Anthropic, [Building effective agents](https://www.anthropic.com/engineering/building-effective-agents) — simplicity, routing, stopping conditions, and evaluation.
- Microsoft, [Disambiguate customer intent](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/cux-disambiguate-intent) — when to clarify, targeted questions, options, and out-of-scope handling.
- Microsoft, [Design graceful fallbacks and handoffs](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/cux-fallbacks) — two-question fallback limit and context-preserving handoffs.
- GOV.UK Design System, [Question pages](https://design-system.service.gov.uk/patterns/question-pages/) — necessary information, one question at a time, and no repeated asks.
- Anthropic, [Trustworthy agents in practice](https://www.anthropic.com/research/trustworthy-agents) — meaningful human control and calibrated stop-or-ask behavior.
- Google SRE, [Incident Response](https://sre.google/workbook/incident-response/) — early incident handling, mitigation, communication, and control.
- Agent Skills, [Specification](https://agentskills.io/specification) — triggering metadata, progressive disclosure, focused references, and validation.

## Keep / improve / move / remove

### Keep

- Clear requests bypass routing questions.
- Active production impact preempts the menu.
- Ask one question at a time and allow free-form answers.
- Keep routing separate from implementation.
- Accept corrected intent immediately.

### Improve

- Replace the fixed wizard with context-specific classification.
- Cover every bundled Yo skill and unsupported normal-work cases.
- Preserve the complete handoff context.
- Detect the available question interface instead of assuming one platform.
- Treat meaningful approval as a specific user decision, not a generic route.
- Limit failed disambiguation to two attempts.

### Move

- Move the complete skill catalog and common chains to `routing-map.md`.
- Move menu construction and examples to `clarification-patterns.md`.
- Keep source rationale here rather than in normal execution context.

### Remove

- Remove every required non-Yo dependency.
- Remove the stale claim that Codex has no structured question control.
- Remove the always-first Q1 and duplicated Q2 submenus.
- Remove duplicated `yo-gh-write` artifact classification.
- Remove unsupported numerical rules derived from Hick's Law, 7-plus-or-minus-2,
  or screen size.
- Remove downstream implementation policy from the router.

## Classification notes

- The routing and clarification rules above are evidence-backed workflow design.
- "Use only bundled Yo skills" is the user's bundle boundary, not a universal
  engineering claim.
- The available question UI is live platform capability and must be detected at
  runtime, not documented as a permanent fact.
- Individual Yo skill triggers and handoffs are bundle contracts and should be
  verified against their live `SKILL.md` files when the bundle changes.

## Golden-quality routing note

Top-tier quality does not automatically require a larger workflow. Google,
Microsoft, Anthropic, and OpenAI engineering guidance supports small scoped
changes, simple effective patterns, and focused verification. See
[the bundle quality standard](../../yo-engineering/references/quality-standard.md).

Derived rule: keep clear low-risk work in the direct lane while applying the
same correctness floor, focused proof, and final simplification pass.
