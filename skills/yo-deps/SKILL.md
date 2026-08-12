---
name: yo-deps
description: >-
  Evaluate and change third-party dependencies with supply-chain, compatibility,
  and reproducibility discipline. Use when adding, upgrading, removing, pinning,
  or replacing packages; triaging dependency advisories; reviewing bot update
  waves; or deciding between an external component and maintained local code.
---

# Yo Dependencies

## Outcome

Make the smallest justified dependency-graph change and prove that the resulting
graph is authentic, policy-compatible, reproducible, behaviorally compatible,
and supportable over time.

A dependency is neither automatically bad nor automatically safer than local
code. Reuse can avoid reimplementing complex standards and security-sensitive
behavior; every external component also creates an ongoing compatibility and
supply-chain relationship. Decide from the actual capability and graph.

Do not add a package, wrapper, adapter, provider interface, or configuration
surface for hypothetical reuse or a possible future replacement. It must solve
a current capability, preserve an existing repository boundary, reduce total
complexity now, or contain a demonstrated compatibility/security risk.

The default endpoint is a verified local working tree. Adding or upgrading a
package does not imply permission to commit, push, open a PR, enable automerge,
deploy, or publish anything.

## Modes

- **Evaluate or add** - decide whether a candidate is necessary and suitable,
  then introduce it if authorized.
- **Upgrade or remove** - understand the exact old-to-new contract and change
  one coherent compatibility unit.
- **Advisory response** - confirm the installed path, affected range, exposure,
  and safest remediation before assigning local priority.
- **Update wave** - remain the dependency-domain owner, cluster related
  packages, and apply `yo-fix-loop` ledger/disposition mechanics without losing
  individual alerts or updates. Do not hand an unchanged cluster back and forth.

Restoring an already-declared graph without changing manifests or resolution is
ordinary setup, not a dependency decision.

## Preserve authority and current truth

- Follow repository instructions, package-manager policy, approved registries,
  and existing manifest and lock conventions.
- Treat uncommitted work as user-owned and keep unrelated manifest or lockfile
  changes out of scope.
- Current releases, ownership, advisories, provenance, and compatibility data are
  time-sensitive. Verify them from canonical registries, upstream repositories,
  and official advisories. "Local only" limits mutations and delivery; it does
  not prohibit read-only research unless the user also says offline or no network.
- Pause when the candidate violates policy, has unclear license terms, introduces
  a material architectural commitment, requires a consequential scope expansion,
  or cannot be evaluated with available evidence.
- Never turn license metadata into legal advice. Check project policy and surface
  uncertainty to the appropriate decision owner.

Use `references/playbook.md` for compact evaluation and graph-diff templates.

## 1. Orient to the existing graph

Before selecting or changing anything, establish:

- ecosystem, package manager and version, workspace boundaries, manifests, and
  reproducibility files;
- application, library, build-tool, development-only, optional, or peer scope;
- exact currently resolved version and every path that brings it into the graph;
- supported language, runtime, operating-system, architecture, and toolchain
  ranges;
- existing components that already provide the capability;
- repository security, license, version-range, and update policies;
- call sites, configuration, generated artifacts, and tests that observe it.

Do not import an undeclared transitive package merely because it happens to be
present today. If first-party code relies on it directly, declare it directly or
use the actual direct dependency's supported API.

## 2. Define the capability before choosing the supplier

State the smallest required capability and its constraints: data formats,
correctness, performance, security boundary, browser/server/native environment,
bundle or image budget, and compatibility lifetime.

Compare:

1. platform or standard-library support;
2. an already-declared direct dependency;
3. maintained local code;
4. one or more external candidates.

There is no line-count threshold. A tiny cryptographic, parser, protocol, date,
Unicode, or serialization implementation can be harder and riskier to maintain
than a substantial ordinary helper. Conversely, a stable local transformation
may not justify a large graph or privileged install script. Compare total
correctness and lifetime cost, not initial typing effort.

If the user explicitly requested a named package, evaluate that package rather
than reopening the choice gratuitously. Proceed with the authorized local change
when it fits; pause and explain when evidence shows it is unsuitable.

## 3. Evaluate proportionately

Evaluate the exact package and version, not the brand in the abstract.

### Identity and provenance

- canonical package name, namespace, registry, upstream repository, and release;
- publisher or organization continuity and typosquatting/confusion risk;
- registry integrity data, signed artifacts, or build provenance when available;
- whether source, tag, published artifact, and attestation correspond.

Absence of provenance is a risk signal, not automatic proof of compromise.

### Functional and compatibility fit

- required API and secure defaults;
- runtime, platform, module-system, type, and peer compatibility;
- stability and deprecation policy;
- fit with repository idioms and the cost of an adapter or eventual exit.

### Project and security health

- maintenance appropriate to the project's maturity, not release recency alone;
- issue and vulnerability-response history, security policy, release process,
  automated tests, and review practices;
- known vulnerabilities or malicious-package reports for the exact version;
- OpenSSF Scorecard, OSPS Baseline, audits, adoption, and maintainer diversity as
  corroborating signals, never a single pass/fail score.

### Graph and execution surface

- added, removed, and changed direct and transitive nodes;
- duplicate or conflicting versions and peer constraints;
- native code, binaries, install hooks, code generation, plugins, network access,
  filesystem access, and other build-time execution;
- runtime, development, bundle, startup, container, and deployment footprint.

### License and support fit

- license expression and source terms for the exact version and transitive graph;
- compatibility with the repository's documented policy and distribution model;
- ownership for updates, vulnerability monitoring, migration, and replacement.

Unknown or non-standard license data requires clarification; popularity does not
resolve it.

Scale depth to risk. A mature direct patch with no meaningful graph delta needs
far less ceremony than a framework, ORM, compiler, native binary, authentication
library, parser for hostile input, build plugin, or package with install scripts.
Use `yo-engineering` for high-risk choices and `yo-design` when the dependency
sets architecture or creates high exit cost.

## 4. Choose a version and change unit

Choose the lowest-risk supported version that satisfies the capability and
policy. Do not blindly select `latest`, a floating branch, a prerelease, or an
old version solely to minimize diff size.

For an upgrade:

- record exact current and target versions;
- read official release notes, changelog, migration guide, support matrix,
  deprecations, and security fixes across the entire crossed span;
- inspect peer and platform requirements before mutating the graph;
- treat semantic versioning as maintainer intent, not compatibility proof;
- include required migrations and obsolete workaround removal when they form one
  coherent, verifiable change.

Define the change unit by compatibility, not package count. Packages released and
supported as a lockstep family, peer set, BOM, SDK, or toolchain may need one
atomic upgrade. Keep unrelated updates separate when that improves failure
attribution. Do not impose one-package-per-commit; `yo-branch` owns commit and PR
shape when delivery is requested.

## 5. Modify the graph through the ecosystem

- Use the repository's package manager and supported migration tools rather than
  hand-editing generated resolution data.
- Change the manifest, directness, scope, version range, overrides, workspace
  metadata, and reproducibility files that the ecosystem and repository expect.
- Review the complete manifest and resolved-graph diff, including unexpected
  removals, upgrades, downgrades, source changes, scripts, and integrity changes.
- Do not normalize or regenerate unrelated files merely because the tool can.
- Keep imports narrow. For high-exit-cost APIs, contain vendor-specific behavior
  behind an existing boundary or a justified adapter; do not wrap packages by
  reflex.
- Add or update tests for the behavior this project relies on, not for the
  supplier's entire API.

Lockfiles are ecosystem artifacts, not a universal filename or policy. Preserve
and review the repository's committed resolution/checksum files. For ecosystems
without one conventional lockfile, follow their native reproducibility model.

Overrides, resolutions, exclusions, vendoring, and forks are explicit risk
decisions. Record why they exist, their owner, verification, and removal trigger.
Never leave an emergency override as invisible permanent policy.

## 6. Verify the changed graph

Verification is layered and proportional:

1. **Resolution integrity** - manifests and reproducibility files agree; the
   intended versions and sources resolve with the supported package-manager mode.
2. **Graph review** - explain every direct change and material transitive delta;
   check advisories, license policy, scripts, provenance, and peer conflicts.
3. **Clean restore** - when practical, restore from declared files in a clean or
   cache-independent environment using the repository's frozen/locked behavior.
4. **Focused behavior** - run tests and realistic flows that exercise the APIs,
   defaults, error paths, and formats the project actually uses.
5. **Project gates** - run affected lint, type, build, unit, integration, and
   platform checks. A compile-only green is weak evidence for behavioral changes.
6. **Operational effects** - where relevant, compare bundle or image size,
   startup, runtime performance, native portability, generated output, and
   deployment packaging.
7. **Final diff** - confirm that only authorized code and graph changes remain.

Then remove any newly added wrapper, helper, configuration, override, or direct
dependency that is not required by the current capability or evidence, and
rerun affected checks. A clean abstraction is still unnecessary when direct use
at the existing seam is clearer and equally safe.

For a broad or high-risk upgrade, use one `yo-audit` pass. Reuse an audit bound
to equivalent graph content and rerun only a changed delta or state-dependent
evidence. Test the resolved set together: compatibility is a property of the
graph, not isolated packages.

## Advisory response

Do not assign local priority from a scanner headline or CVSS score alone.
Use the repository's priority scheme when one exists. Otherwise state urgency,
ordering rationale, and any deadline in plain language; do not invent P-levels.

1. Confirm the exact installed version, dependency path, affected ecosystem and
   version range, advisory aliases, and whether the record was updated or withdrawn.
2. Determine where the component exists: production runtime, build, test,
   development tool, disabled feature, image, artifact, or unreachable residue.
3. Check vulnerable symbol or behavior reachability, attacker preconditions,
   exposed assets, compensating controls, impact, known exploitation, and current
   threat evidence such as CISA KEV or EPSS when applicable.
4. Prefer removal or the smallest supported fixed graph that preserves behavior.
   Upgrade farther when the minimum fix is unsupported or creates worse risk.
5. If no fix exists, choose an explicit containment: disable or isolate the path,
   replace or fork with ownership, apply an upstream patch, or accept time-bounded
   residual risk through the project's authority. Do not invent a pin that leaves
   the same vulnerable code and call it remediation.
6. Re-run the advisory scan, prove the vulnerable path is removed or contained,
   and run behavioral and regression checks.

For a multi-alert wave, preserve each alert, deduplicate aliases, cluster shared
root packages and coupled upgrades, and keep blocked or accepted-risk items
visible using `yo-fix-loop` mechanics. `yo-deps` remains the domain owner; do not
re-enter `yo-fix-loop` after it returns the same unchanged cluster.

## Stop and report

Call the dependency change complete only when the necessity and exact version are
justified, the graph diff is understood, required policy checks pass, and the
resolved graph plus relied-on behavior are verified.

The handoff states:

- capability and chosen package/version or no-dependency decision;
- direct and material transitive graph delta;
- authenticity, provenance, maintenance, security, and license evidence;
- release-note or advisory conclusions and migrations performed;
- exact verification and its outcome;
- overrides, residual risks, unsupported environments, and rollback/removal path;
- local working-tree and delivery state.

If evidence is unavailable, say unknown. If the graph resolves but runtime proof
did not run, say partially verified. Never describe an advisory as remediated
when it is merely unreachable by assumption or temporarily suppressed.

## Anti-patterns

- Installing before establishing package identity and need.
- Choosing local code or a package from an arbitrary line count.
- Importing an undeclared transitive dependency.
- Trusting popularity, release recency, Scorecard, SemVer, or CVSS alone.
- Reviewing only the top-level manifest and ignoring the resolved graph.
- Treating every package as independent when the ecosystem supports it as a set.
- Regenerating unrelated lock or workspace data.
- Calling a successful install or compile behavioral verification.
- Suppressing an advisory without an owned, time-bounded rationale.
- Assuming a dependency edit authorizes commits or external delivery.

## Research basis

Primary sources and the rules derived from them are in
`references/sources.md`.
