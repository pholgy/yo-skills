# Release record and templates

Use the repository's durable release system when it has one. These templates are
fallback structures; do not create a file or public record unless requested.

## Contract snapshot

```markdown
Product/package and audience:
Release owner / approvers:
Source branch or revision policy:
Version/build identifier scheme:
Tag format and signing policy:
Changelog / notes destinations:
Build workflow and artifact registry:
Required provenance / SBOM / signatures / checksums:
Promotion environments or distribution channels:
Rollout gates / merge or release queue:
Previous released source and artifact:
Current production/source artifact:
Rollback / disable / deprecate / roll-forward path:
Communication and support window:
```

## Release unit

```markdown
Pinned candidate SHA/source:
Previous release identifier and source:
Proposed version/build/tag:
Artifacts and target platforms:
Target channels/environments:
Included PRs/changes:
Excluded or already released changes:
Migrations/config/flags/dependencies:
```

For a monorepo, repeat the previous/candidate/version/artifact fields per product.

## State ledger

Include only requested or repository-coupled boundaries. Do not add empty
staging, canary, or production rows to a source/tag or artifact-only release.

| Boundary | Intended identity | Current state | Evidence | Authority / next action |
| --- | --- | --- | --- | --- |
| Source | commit SHA | planned/validated | CI and review | |
| Version/tag | exact identifier -> SHA | absent/draft/published/conflict | remote/registry query | |
| Artifact | name@digest per platform | absent/building/published/verified | registry + provenance | |
| Staging | digest/config | not started/deployed/verified | runtime query + smoke | |
| Canary | digest/cohort | not started/running/healthy/aborted | comparison window | |
| Production | digest/config/coverage | not started/partial/full/verified | runtime + telemetry | |
| Notes/status | destination/revision | draft/published/verified | URL or record ID | |

Never collapse a partial row into one global "released" flag.

## Collision matrix

| Existing state | Safe default |
| --- | --- |
| Identifier absent everywhere | Continue after final preflight |
| Same identifier and exact same source/artifact, later stage missing | Resume the missing stage idempotently |
| Same identifier but different source/artifact | Stop; choose a new identifier or obtain exceptional repair authority |
| Draft record, tag not consumed, nothing published | Repair/retire only under policy and explicit authority; recheck for races |
| Tag exists and tag-triggered build may have run | Inventory artifacts and runs before any repair |
| Artifact/version publicly available | Preserve it; use new release plus deprecation/yank/roll-forward as supported |
| Deployment partial or state unknown | Freeze rollout and inventory every target before resuming or rolling back |

Deleting a draft does not prove a tag was unobserved. Deleting a tag does not
delete caches, artifacts, workflow runs, or consumer clones.

## Notes draft

Adapt to the project template and audience.

```markdown
# <version or release name>

## Highlights
<User-relevant outcome, concise.>

## Breaking changes and migration
<What breaks, who is affected, exact migration. Omit if none.>

## Added
- ...

## Changed
- ...

## Fixed
- ...

## Known issues
- <Impact and workaround, only when real.>

## Upgrade / availability
<Supported upgrade path, channels, rollout caveat.>
```

Operator-only notes can separately cover configuration, migrations, flags,
observability, rollout, and rollback. Keep embargoed security detail out of a
public draft.

## Preflight

### Every selected endpoint

- exact source and previous release resolved;
- contents and exclusions reconciled;
- version/tag/registry collision checks clean;
- review and required CI bound to candidate;
- generated version/notes/manifests agree;

### Artifact endpoint, when selected

- artifacts built through the controlled workflow and identified by digest;
- required provenance/SBOM/signature/checksum/security/license policy passes;
- platform, integration, upgrade, and migration verification passes;
- rollback/disable/deprecate/roll-forward path is executable and state-compatible;

### Deployment endpoint, when selected

- rollout stages, signals, abort thresholds, observer, and stability windows set;
- approvals, permissions, release lock, support, and incident escalation available;
- no unresolved active incident or freeze blocks the release.

Omit an unselected section; do not fill it with `N/A` placeholders.

## Rollout gate

```markdown
Stage / cohort:
Artifact digest and config:
Control or baseline:
User and system signals:
Data/security invariants:
Observation window:
Proceed threshold:
Abort threshold and action:
Owner / approval / timestamp:
Actual result:
```

## Final handoff

```markdown
Release status:
Candidate SHA:
Version/tag and target SHA:
Artifact digest(s), provenance, signatures:
Published channels / deployed environments:
Behavioral and operational verification:
Notes/status destinations:
Partial/failed/skipped stages:
Rollback floor and residual risk:
Next action and owner:
```
