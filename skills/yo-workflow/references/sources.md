# Research and decisions

Authority labels:

- **K:** official standard/platform contract
- **I:** official engineering guidance or case study
- **M:** peer-reviewed or controlled empirical research

## Evidence map

### Agent architecture must match task structure

- **M - Google Research, Towards a science of scaling agent systems (2026):** a controlled study of 180 configurations found centralized multi-agent gains on parallelizable tasks, substantial degradation on sequential tasks, tool-coordination overhead, and lower error amplification under centralized coordination than independent aggregation. This directly supports task-graph selection, a central synthesizer, and no "more agents is better" rule.
  <https://research.google/blog/towards-a-science-of-scaling-agent-systems-when-and-why-agent-systems-work/>
- **I - Anthropic, Building Effective Agents:** distinguishes parallel sectioning, orchestrator-workers, and evaluator-optimizer; recommends clear criteria, environmental ground truth, explicit stopping conditions, and adding complexity only when outcomes improve.
  <https://www.anthropic.com/engineering/building-effective-agents>
- **I - OpenAI, A practical guide to building agents:** recommends maximizing a single agent first, moving to manager-led multi-agent systems when complexity warrants it, using clear structured instructions, guardrails, and explicit run exit conditions.
  <https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/>
- **I - Anthropic, How we built our multi-agent research system:** reports that breadth-first independent directions benefit from orchestrator-workers, while coding has fewer parallelizable tasks; emphasizes precise worker objectives, output formats, task boundaries, centralized synthesis, provenance, evals, observability, and the high coordination/token cost of multi-agent systems.
  <https://www.anthropic.com/engineering/multi-agent-research-system>

### Independent challenge helps only when grounded

- **I - NASA IV&V Overview:** separates verification from validation and defines technical independence as assessment independent of the developer. The bundle borrows the technical-independence idea without claiming managerial/financial IV&V.
  <https://www.nasa.gov/ivv-overview/>
- **M - Huang et al., Large Language Models Cannot Self-Correct Reasoning Yet (ICLR 2024):** intrinsic self-correction without external feedback can fail or degrade reasoning. This supports fresh challenge plus code/test/runtime evidence rather than a same-context "look again" ritual.
  <https://proceedings.iclr.cc/paper_files/paper/2024/hash/8b4add8b0aa8749d80a34ca5d941c355-Abstract-Conference.html>
- **M - Gou et al., CRITIC (ICLR 2024):** tool-interactive external feedback improved critique and correction across evaluated tasks. This supports grounding challenge outcomes in executable or inspectable evidence.
  <https://proceedings.iclr.cc/paper_files/paper/2024/hash/fef126561bbf9d4467dbb8d27334b8fe-Abstract-Conference.html>
- **M - Tyen et al., LLMs cannot find reasoning errors, but can correct them given the error location (ACL Findings 2024):** separates mistake finding from correction and shows difficulty locating errors. This supports distinct discovery and challenge jobs with precise candidate locations.
  <https://aclanthology.org/2024.findings-acl.826/>

### Deep review needs system context and explicit coverage

- **I - Google Engineering Practices, What to look for in a code review:** recommends reviewing assigned human-authored lines, reading broader context, and involving qualified reviewers for domains such as privacy, security, concurrency, accessibility, and internationalization.
  <https://google.github.io/eng-practices/review/reviewer/looking-for.html>
- **M - Bacchelli and Bird, Expectations, Outcomes, and Challenges of Modern Code Review:** found change and code understanding central to effective review in Microsoft teams. This supports system mapping before candidate hunting.
  <https://www.microsoft.com/en-us/research/publication/expectations-outcomes-and-challenges-of-modern-code-review/>
- **M - Bosu, Greiler, and Bird, Characteristics of Useful Code Reviews:** analyzed review usefulness at Microsoft and found larger multi-file changes reduced the proportion of useful feedback. This supports partitioning large surfaces into coherent review contracts rather than one undifferentiated prompt.
  <https://www.microsoft.com/en-us/research/publication/characteristics-of-useful-code-reviews-an-empirical-study-at-microsoft/>
- **I - OWASP Threat Modeling Project and Secure Code Review:** emphasize scope, actors, dependencies, assumptions, trust/data boundaries, high-risk controls, and manual review complementary to automated tools. This supports the system/coverage map and relevant security lenses.
  <https://owasp.org/www-project-threat-modeling/>
  <https://cheatsheetseries.owasp.org/cheatsheets/Secure_Code_Review_Cheat_Sheet.html>
- **K - NIST SSDF SP 800-218:** includes reviewing, analyzing, and testing human-readable code as secure-development practices. This supports combining review with proportionate automated and executable evidence.
  <https://csrc.nist.gov/pubs/sp/800/218/final>

## Bundle decisions

### Kept

- Separate broad discovery, adversarial verification, synthesis, and completeness passes.
- Read-only review and a clean handoff to the fix workflow.
- Fresh context as a stronger option for material candidate verification.

### Improved

- Architecture is selected by decomposability, shared context, sequential dependency, tool density, and review value.
- A central coordinator owns snapshot, scope, coverage, provenance, uncertainty, and final judgment.
- Review starts with a system/flow/invariant map and uses relevant risk lenses rather than two universal buckets.
- Candidates use a shared evidence schema; challengers classify confirmed,
  refuted, unresolved, out-of-scope, or duplicate. Change attribution is separate,
  so an in-scope pre-existing defect is not discarded.
- Refutation requires counterevidence; consensus and vote counts never establish correctness.
- Stop conditions and coverage states make partial review honest and measurable.

### Moved or removed

- Platform/model/shell/session details moved to the appropriate execution skill, especially `yo-codex` for Claude-to-Codex delegation.
- Removed hard-coded model names, bash fan-out, arbitrary concurrency, and configuration assumptions.
- Removed repository scratch files, default-to-refuted behavior, fixed two-lens fan-out, and the claim that one complex flow never qualifies.
