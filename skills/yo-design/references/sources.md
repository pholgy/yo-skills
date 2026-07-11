# Research and decisions

Authority labels:

- **K:** official project/process contract
- **I:** official engineering guidance
- **R:** influential practitioner source

## Evidence map

### Design review is scenario and tradeoff analysis

- **I - CMU Software Engineering Institute, ATAM collection:** evaluates architectures against prioritized quality-attribute scenarios and identifies risks, sensitivity points, and tradeoff points before implementation. This supports concrete decision drivers rather than generic "scalable/reliable" claims.
  <https://www.sei.cmu.edu/library/architecture-tradeoff-analysis-method-collection/>
- **K - Kubernetes Enhancement Proposal template:** mature production-change proposals include motivation, goals/non-goals, risks, test plan, graduation criteria, upgrade/downgrade, version skew, rollout/rollback, monitoring, dependencies, scalability, and troubleshooting. This supports transition and operability sections for consequential designs.
  <https://www.kubernetes.dev/resources/keps/5468/>
- **K - Rust RFC process:** major proposals require convincing motivation, impact understanding, drawbacks, alternatives, and collaborative review before implementation. This supports fair alternatives and review while the approach is contestable.
  <https://rust-lang.github.io/rfcs/>
- **I - Google Cloud approach to change:** describes common design review for major changes before implementation and staged rollout practices intended to reduce customer-impact risk.
  <https://docs.cloud.google.com/docs/cloud-approach-to-change>

### ADRs capture significant choices and evolving rationale

- **I - Google Cloud, Architecture decision records overview:** ADRs capture key options, requirements, and decisions; should be accessible near relevant code or another team-visible system; and preserve prior decisions when architecture evolves.
  <https://docs.cloud.google.com/architecture/architecture-decision-records>
- **I - AWS Prescriptive Guidance, ADRs:** frames ADRs as a lightweight process for alignment, strategic direction, decision rationale, and avoiding repeated debates.
  <https://docs.aws.amazon.com/prescriptive-guidance/latest/architectural-decision-records/welcome.html>
- **R - Michael Nygard, Documenting Architecture Decisions:** popularized the lightweight Status/Context/Decision/Consequences record and supersession lifecycle.
  <https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions>
- **I - UK Government Digital Service, Architecture decisions:** recommends recording meaningful decisions, retaining prior records, and marking superseded decisions rather than erasing implemented history.
  <https://gds-way.digital.cabinet-office.gov.uk/standards/architecture-decisions.html>

### Repository convention beats a universal template

- **I - ADR community:** catalogs multiple templates and decision-capture practices, reflecting that no single numbering or section format fits every project.
  <https://adr.github.io/>
- **R - Design Docs at Google (Malte Ubl):** an influential public practitioner account emphasizing design docs as pre-implementation review vehicles for context, tradeoffs, and consensus rather than merely archival prose.
  <https://www.industrialempathy.com/posts/design-docs-at-google/>

## Bundle decisions

### Kept

- Design before expensive implementation, real alternatives, goals/non-goals, compatibility, rollback, verification, and durable decision rationale.
- One architecturally significant decision per ADR and supersession for changed decisions.
- Honest labeling for retroactive records.

### Improved

- Added advice, draft, record, and review modes with explicit write/publication authority.
- Artifact choice now follows proposal-versus-decision lifecycle; a design doc and ADR are not automatically both required.
- Significance depends on reversibility, coordination, uncertainty, contracts, and quality tradeoffs rather than file count or a local tier alone.
- Added concrete quality scenarios, current-state evidence, ownership, security/operations, mixed-version transitions, decision outcomes, and revisit triggers.
- Proposed ADRs may evolve; accepted decisions retain history while transparent factual corrections remain possible.

### Removed

- Universal one-page/three-page limits and mandatory repository paths/numbering.
- An unconditional explicit-approval pause after every design.
- The claim that only irreversible choices deserve ADRs.
- A new superseding ADR for mere typos or repaired source links.
- Automatic file creation or GitHub posting.
- Weak sunk-cost and cost-of-change claims that were not necessary for the workflow.
