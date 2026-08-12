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

### Stateful boundaries keep stable identities and recovery semantics

- **K - OpenID Connect Core 1.0, Claim Stability and Uniqueness:** defines the
  issuer/subject pair as the stable end-user identifier and explicitly rejects
  email and other profile claims as unique identity keys. This supports safe
  federation-linking and takeover-negative cases.
  <https://openid.net/specs/openid-connect-core-1_0.html#ClaimStability>
- **I - AWS Prescriptive Guidance, Transactional outbox:** requires database
  state and outbox intent to share a transaction, treats duplicate delivery as
  normal, and calls out message order. This supports the outbox identity,
  sequence, and failure-window design fields.
  <https://docs.aws.amazon.com/prescriptive-guidance/latest/cloud-design-patterns/transactional-outbox.html>
- **K - Amazon S3, How Versioning works:** distinguishes multiple immutable
  versions under the same key and requires a version ID to retrieve or delete a
  specific version. This supports exact-object identity through quarantine,
  scan, promotion, download, and cleanup.
  <https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html>

### Stateful network designs use provider-real controls

- **I - AWS, Private NAT Gateway:** ordinary peering and Transit Gateway cannot
  connect overlapping CIDRs; the documented pattern allocates non-overlapping
  routable subnets, uses Private NAT Gateway for source NAT, ELB for destination
  NAT, and Transit Gateway for the alias route.
  <https://docs.aws.amazon.com/whitepapers/latest/building-scalable-secure-multi-vpc-network-infrastructure/private-nat-gateway.html>
- **I - AWS, Transit Gateway routing and appliance mode:** TGW evaluates equal
  BGP prefixes by AS-path then MED, and appliance mode keeps a stateful flow on
  one appliance Availability Zone. Network Firewall attachments are inspection
  functions with appliance mode, not the overlapping-CIDR translation step.
  <https://docs.aws.amazon.com/vpc/latest/tgw/how-transit-gateways-work.html>
- **I - AWS, Site-to-Site VPN route priority:** tunnel health precedes BGP
  attributes; equal prefixes use AS-path and then MED, and asymmetric paths can
  drop traffic on devices that cannot support them.
  <https://docs.aws.amazon.com/vpn/latest/s2svpn/vpn-route-priority.html>
- **I - Google Cloud, HA VPN topologies and advertised routes:** active-passive
  routing uses differing MED priorities while both tunnels remain active;
  per-session base advertised priority becomes MED, with explicit warnings to
  verify how the peer selects it.
  <https://docs.cloud.google.com/network-connectivity/docs/vpn/concepts/topologies>
  <https://docs.cloud.google.com/network-connectivity/docs/router/concepts/advertised-routes>
- **K - Google Cloud, BGP route policy attributes:** import and export policies
  can set MED and prepend AS-path, enabling an explicit bidirectional selection
  contract rather than generic communities or local-preference claims.
  <https://docs.cloud.google.com/network-connectivity/docs/router/reference/bgp-route-policy-reference>

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
- Boundary crossing is a significance signal rather than an automatic design
  workflow. Established, additive, reversible choices with known consumers stay
  inline unless a material contract, migration, security, operational, or
  uncertainty driver earns broader design work.
- Multi-provider lifecycle designs now require explicit field authority, stable
  identity mapping, idempotency, ownership-safe compensation, reconciliation,
  provider-contract evidence, and secret hygiene; provider capability alone
  never grants destructive authority.
- Stateful network designs must name provider controls that implement
  translation, route preference, symmetric inspection, and maintenance
  transition; generic NAT/BGP labels are insufficient.
- A preferred topology remains an alternative, not a constraint. For finite
  services on overlapping CIDRs, compare PrivateLink with translated TGW and
  stop for selection before detailing one branch.
- An unresolved owner choice is terminal for the current design turn: compare
  only viable options and discriminating evidence, then defer branch-specific
  topology, rollout, audit, and optional integration checks until selection.
- Complex design handoffs make the future audit boundary self-contained: judge
  the carried exact evidence bundle and selectively reproduce only stale,
  challenged, state-dependent, or decision-critical proof.
- Multi-provider event admission uses a durable inbox with a unique
  provider/event identity before current-state reconciliation; a bare in-memory
  deduplication claim is insufficient.
- Concurrency proof covers bounded materially distinct schedule and failure
  classes with invariants rather than requiring an exhaustive Cartesian
  permutation program.
- The deferred network acceptance explicitly includes complete forward/return
  paths and stateful symmetry, not only allow/deny reachability.
- Multi-region collaboration does not imply zero RPO. Set merge semantics,
  acknowledged-edit RPO/RTO, and failover authority before choosing writer and
  acknowledgement architecture.

### Removed

- Universal one-page/three-page limits and mandatory repository paths/numbering.
- An unconditional explicit-approval pause after every design.
- The claim that only irreversible choices deserve ADRs.
- A new superseding ADR for mere typos or repaired source links.
- Automatic file creation or GitHub posting.
- Weak sunk-cost and cost-of-change claims that were not necessary for the workflow.

## 2026 Golden Engineering Standard update

Google SRE treats accidental complexity as a reliability cost, and Anthropic
recommends starting with the simplest effective pattern and adding complexity
only when outcomes require it. Microsoft's engineering playbook emphasizes
precise, incremental value. The primary links and exact Yo policy are in
[the bundle quality standard](../../yo-engineering/references/quality-standard.md).

Derived rule: compare every proposal with the simplest viable direct option and
require a current scenario, contract, boundary, or demonstrated risk for every
new architectural mechanism.

The same evidence supports a cost gate for the workflow itself: future-rationale
value may reinforce a material decision, but it does not justify a design cycle
for an otherwise local and reversible choice.
