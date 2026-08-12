---
name: yo-release
description: >-
  Plan, prepare, publish, promote, verify, or recover a software release using
  the repository's actual versioning and delivery contract. Use for release
  contents and notes, version changes, tags, package or binary publication,
  GitHub Releases, environment promotion, production rollout, and release status.
---

# Yo Release

## Outcome

Move one precisely identified source revision and artifact set through the
requested release boundaries, then prove what users can obtain or what production
is actually running. Keep source, version, tag, artifact digest, provenance,
environment, notes, and verification aligned.

A tag is not necessarily a release. A published package is not necessarily
deployed. A deployment is not necessarily verified. Track each requested
endpoint separately.

Use `references/release-record.md` for the contract snapshot, state ledger,
collision matrix, notes, rollout, and final evidence templates.

## Modes and authority

- **Inspect/report** - read current release state or changes since a release; no
  mutations.
- **Draft notes** - return text in chat unless a file or post is explicitly
  requested.
- **Prepare** - update authorized version/changelog/release metadata and validate
  a candidate; do not tag, publish, or deploy.
- **Publish** - create the repository's tag, package, binary, image, or release
  record through its documented workflow.
- **Promote/deploy** - move an existing immutable artifact through named
  environments or channels.
- **Verify/recover** - prove availability and runtime state, or contain a failed
  release through its defined rollback/forward path.

Honor explicit exclusions. "Write release notes" does not authorize edits or a
release. "Tag this" does not automatically authorize pushing the tag or publishing
artifacts. A clear request to release authorizes the repository's documented
standard release path, but if that path has materially different public endpoints
such as package publication versus production deployment, resolve the intended
endpoint before the first irreversible action.

Do not invent `main`, `develop`, SemVer, Git tags, GitHub Releases, changelogs, or
production deployment when the project does not use them. `yo-branch` owns branch,
commit, PR, protection, and merge mechanics needed to prepare a release source.

## 1. Discover the release contract

Read live repository and platform truth:

- release instructions, workflows, manifests, version tooling, and ownership;
- source branch or approved revision and its branch-protection path;
- product/package boundaries in a monorepo and fixed versus independent versions;
- version scheme, prerelease/channel rules, tag format, and tag-signing policy;
- changelog and release-note templates and audiences;
- build, test, artifact registry, SBOM, provenance, signature, and checksum policy;
- environments, rollout stages, approvals, deployment automation, and freeze state;
- previous released source/artifact, current production artifact, and rollback or
  containment mechanism;
- permissions, release locks, concurrent automation, and external publication
  destinations.

Current remote refs, registries, releases, deployments, and pipeline state are
time-sensitive. Refresh before deciding and immediately before publishing.

If the repository has no durable release contract, describe the minimum safe one
and ask only for choices that change the externally visible outcome. Do not
silently establish policy while shipping.

## 2. Pin the release unit

Identify the candidate immutably:

- exact source commit or approved source set;
- exact previous released commit, tag, version, or deployed artifact for this
  product/channel;
- exact artifact names, platforms, package scopes, and target channels;
- proposed version or build identifier when the contract uses one.

The moving branch name is not the release candidate. Once the candidate SHA is
pinned, later branch commits belong to a later release unless the candidate is
deliberately replaced and all evidence is rerun.

For a service, the release unit may be `source SHA -> immutable image digest` with
no public version or tag. For a monorepo, each package may have a different
previous release and candidate. For a mobile or staged marketplace release,
availability can differ by platform or review channel.

Determine contents from ancestry and artifact truth, not date searches alone.
Compare the previous released source with the pinned candidate and reconcile
merged PRs, cherry-picks, reverts, generated changes, migrations, dependency
updates, flags, and configuration. Confirm that the candidate contains exactly
the intended changes and no already-released or excluded work.

## 3. Decide version and communicate change

Follow the project's version policy:

- SemVer for a declared public API contract;
- CalVer, build numbers, marketing versions, independent package versions,
  prerelease identifiers, or immutable digests when those are the contract;
- project-defined pre-1.0 semantics rather than assuming `0.x` behavior.

Under SemVer, classify against the documented public contract: incompatible
change -> major; backward-compatible capability -> minor; backward-compatible fix
-> patch. SemVer is maintainer intent, not proof that downstream behavior is safe.

Check the proposed identifier across source tags, package/image registries,
release records, app stores, and deployment systems before editing. Never reuse a
published version to represent different content.

Write notes for the actual audience and project template. Separate, when needed:

- user-facing features, fixes, breaking changes, migration, and known issues;
- operator changes, configuration, rollout, data migration, and observability;
- restricted security detail from public disclosure.

Do not dump commit subjects. Mention dependencies or internal work only when they
change user behavior, compatibility, security, licensing, or operator action.
Hand final prose to `yo-gh-write` when the destination is a GitHub artifact.

### Select the endpoint contract

Apply release gates only to requested endpoints:

| Endpoint | Required proof | Do not inherit automatically |
|---|---|---|
| Source/tag or GitHub release record | Pinned source, identifier collision/immutability, required review/CI, remote record | Artifact install, deployment, canary, stability window, support coverage |
| Package, binary, or image artifact | Source plus controlled build, digest, registry availability, install/fetch path, and policy-required attestations | Environment promotion, canary/control, production telemetry, incident staffing |
| Environment promotion or deployment | Immutable artifact, target config/state, rollout/abort/rollback controls, runtime and operational verification | Unrelated registries, platforms, or channels outside the requested target |

An omitted inapplicable endpoint or gate needs no `N/A` record and is not a
blocker. If the repository's documented release contract couples endpoints,
follow that contract and name the coupling.

## 4. Gate the candidate before publication

The preflight must bind evidence to the exact candidate:

1. source revision passed the repository's review/protection path;
2. required CI, focused behavior, compatibility, and platform tests pass on that
   revision or on the exact release-generated diff;
3. version, notes, manifests, generated files, and release configuration agree;
4. when an artifact endpoint is selected, the controlled build produces
   identified artifacts with recorded digests;
5. SBOM, provenance, signatures, checksums, vulnerability/license policy, and
   reproducibility checks required by the selected artifact endpoint pass;
6. when migrations or configuration change, they are compatible with the real
   transition or their irreversible cutover and recovery plan is authorized;
7. for staged promotion or deployment, rollout stages, canary/control signals,
   abort thresholds, observer, and stability windows are defined;
8. the endpoint's rollback, disablement, yanking/deprecation, or roll-forward
   path is valid for its artifact and ecosystem;
9. approvers, credentials, release window, support coverage, and incident
   escalation required by policy or the selected deployment endpoint are available.

Prefer build once and promote the same immutable artifact through environments.
Rebuilding at each stage changes what was tested. If an ecosystem necessarily
rebuilds, record and verify the source-to-artifact provenance at every boundary.

Database and state changes require special proof: old/new application
compatibility, mixed-version operation, write behavior, rollback floor,
reconciliation, and backup/recovery assumptions. A previous binary is not a valid
rollback merely because it ran before the migration.

## 5. Make publication idempotent and collision-safe

Immediately before a public step, re-read the intended version, tag, draft or
published release, registry artifact, pipeline, and deployment state.

- Same identifier, same source/artifact, same intended metadata -> resume only
  missing verified stages; do not duplicate them.
- Same identifier, different source or artifact -> stop. The identifier is in
  conflict and must not be force-moved or overwritten.
- Draft/unpublished record with no consumed artifact -> repair or retire only
  under repository policy and explicit authority, then recheck races.
- Published tag/version/artifact -> treat as immutable. Correct with a new release,
  yanked/deprecated marker, or ecosystem-approved recovery—not silent replacement.
- Unknown or partially published state -> inventory every boundary before acting.

Tag creation must fail on collision. Follow repository policy for lightweight,
annotated, or signed tags; do not force a universal tag type. Never move or delete
a public tag merely to make the release command pass.

## 6. Execute the documented pipeline

Use the repository's automation rather than reproducing release steps manually.
Pin the exact input, use least privilege, and record each transition in the
release ledger.

Depending on the contract, execution may include:

- merge or release-PR completion through `yo-branch`;
- tag or version record creation;
- controlled build and artifact publication;
- draft then immutable release publication with all assets attached;
- promotion of the same digest through staging, canary, regional/cohort waves,
  production, and public distribution channels;
- authorized notes, changelog, status, or announcement publication.

Do not run later stages while an earlier required stage is pending or failed.
At each rollout gate, compare canary and control or the declared baseline, verify
incident-specific abort signals, and stop on threshold breach. Do not continue a
rollout because most stages already succeeded.

These rollout-gate instructions apply only when staged promotion or deployment
is a selected endpoint.

## 7. Verify what users receive and production runs

Verification is endpoint-specific:

- **Source/tag** - remote tag or release record points to the pinned revision and
  satisfies signature/immutability policy.
- **Artifact** - the intended registry/channel serves the exact digest; install or
  fetch through the user path; verify checksum, signature, provenance, SBOM, and
  platform variants as required.
- **Deployment** - each target actually runs the intended artifact digest and
  configuration; migrations and feature controls are in the expected state.
- **Behavior** - headline flows, compatibility, negative cases, data invariants,
  and upgrade/install path pass using safe probes or approved test accounts.
- **Operations** - errors, latency, traffic, saturation, security, business, and
  rollout-specific signals remain healthy for the declared stability window.

Verify caches, mirrors, app-store tracks, regions, or package indexes when they
affect availability. A successful pipeline event is evidence of execution, not
proof that users can obtain or safely use the release.

## 8. Handle failure and close honestly

Classify the exact state:

- candidate not published;
- source/tag published but artifact missing or failed;
- artifact published but not promoted;
- partially promoted;
- deployed but not behaviorally verified;
- available and verified at all requested endpoints.

Abort before publication when possible. After publication, preserve immutable
history and use the ecosystem's recovery mechanism. A package may need a new
patch and deprecation/yank; a service may shift traffic, disable a feature, or
redeploy the previous compatible digest; a data migration may require roll-forward
and reconciliation rather than binary rollback.

If a release causes active user, data, or security impact, switch to
`yo-incident`. Do not improvise destructive cleanup inside the release workflow.

Call the release complete only when every requested endpoint is in a verified
state and notes/status accurately describe it. Report candidate SHA, version/tag,
artifact digests, provenance/signing state, stages and timestamps, verification,
partial or failed boundaries, rollback floor, residual risk, and next action.

## Anti-patterns

- Hardcoding `develop -> main -> tag -> GitHub Release`.
- Choosing SemVer or a version bump for a project that uses another release unit.
- Comparing releases by date while ignoring ancestry, reverts, or per-package state.
- Rebuilding different artifacts for staging and production without provenance.
- Force-moving a colliding tag or replacing a published artifact.
- Treating draft notes as permission to edit, post, publish, or deploy.
- Calling a green pipeline, pushed tag, or deployed percentage "released" without
  endpoint verification.
- Rolling back across incompatible schema or state.
- Hiding a partially released state behind a success summary.

## Research basis

Primary sources and derived rules are in `references/sources.md`.
