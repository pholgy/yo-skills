# Dependency decision playbook

Keep records proportional. A routine patch may need only a few lines; a new
runtime framework or high-risk package deserves a durable design record when the
repository uses one.

## Evaluation record

```markdown
Capability:
Candidate and exact version:
Scope: runtime | build | development | test | optional | peer
Alternatives considered:

Identity and provenance:
Functional/platform fit:
Project/security health:
Direct and transitive graph impact:
Execution surface:
License/policy fit:
Upgrade and exit path:

Decision: adopt | reject | replace | defer
Why:
Required verification:
Unknowns or decision owner:
```

Use canonical registry and upstream links in a durable record. Timestamp signals
that change, such as current version, advisory status, or maintainer activity.

## Proportional depth

### Routine

Typical shape: an in-range patch, no runtime-scope change, no new scripts or
native artifacts, small explainable graph delta, supported repository path.

Check exact release notes or advisory, graph diff, reproducible restore, focused
tests, and normal project gates.

### Material

Typical shape: a new runtime package, minor version with meaningful behavior
changes, new transitive suppliers, changed bundle/image surface, or a package
handling important untrusted input.

Compare candidates, inspect maintenance/security/license signals, test realistic
flows and failure cases, and document exit cost.

### High risk

Typical shape: framework, ORM, compiler, package manager, native binary, install
script, authentication/authorization, cryptography, serialization protocol,
privileged build plugin, foundational data model, unknown license, fork, or broad
major migration.

Use senior engineering and design review, inspect provenance and source more
deeply, define rollback/containment, exercise supported platforms, and obtain
independent audit evidence bound to the candidate. Reuse equivalent
content-bound evidence and refresh only changed or state-dependent proof.

These are calibration examples, not fixed labels. A patch can be high risk when
actively exploited; a major can be routine when it is a narrow development tool
with a well-tested migration.

## Graph-diff checklist

- direct package added, removed, upgraded, downgraded, or moved in scope;
- transitive packages added, removed, upgraded, downgraded, duplicated, or
  sourced from a different registry or repository;
- peer, feature, optional, platform, or workspace constraints changed;
- integrity hashes, signatures, provenance, or artifact type changed;
- install/build scripts, native binaries, code generators, or plugins added;
- license expression or unknown-license count changed;
- known advisories introduced, removed, or left reachable;
- bundle, image, startup, generated output, or deployment artifact changed;
- overrides, exclusions, forks, patches, or vendored code introduced;
- unrelated resolution churn present and either explained or removed.

Not every duplicate version is a defect. Record why materially different
versions coexist and whether the ecosystem can safely converge them.

## Upgrade record

```markdown
Current resolved set:
Target resolved set:
Compatibility unit:
Release-note span:
Breaking/default/deprecation changes:
Runtime/toolchain/peer requirements:
Required migrations:
Graph delta:
Behavioral proof:
Rollback or removal path:
```

Coupled packages belong in one compatibility unit when no supported intermediate
state exists. Unrelated packages can share a routine batch only when the batch is
still reviewable and a failure can be attributed efficiently.

## Advisory record

```markdown
Advisory and aliases:
Resolved package/version and dependency path:
Affected range confirmed:
Environment and artifact presence:
Reachable vulnerable behavior:
Attacker preconditions and impact:
Known exploitation / threat evidence:
Compensating controls:
Fixed or supported target:
Chosen remediation or containment:
Residual risk owner and expiry:
Scanner and behavioral verification:
```

`Not reachable` needs evidence. `Not in production` needs artifact or deployment
evidence. A scanner suppression needs the advisory identity, exact scope,
rationale, owner, and review/removal date.

## Removal record

Verify more than deletion from the manifest:

- no first-party imports, reflection, plugins, configuration, generated files,
  or scripts still depend on it;
- the resolved graph no longer contains it unless another path legitimately does;
- replacement behavior and data compatibility pass;
- obsolete adapters, overrides, suppressions, and documentation are removed;
- build and deployment artifacts no longer include the component where intended.
