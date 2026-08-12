# Sources for yo-release

These sources calibrate release identity, versioning, artifact integrity,
automation, rollout, and recovery. Live repository and ecosystem policy wins.

## Release engineering and canarying

Google SRE defines release engineering around hermetic/reproducible builds,
automated builds/tests/deployments, uniquely identifiable artifacts, release
records, and controlled rollout. Its canary guidance defines a canary as a partial,
time-limited deployment evaluated against a control before proceeding.

- Google SRE Book, "Release Engineering"
  https://sre.google/sre-book/release-engineering/
- Google SRE Workbook, "Canarying Releases"
  https://sre.google/workbook/canarying-releases/

Derived rules: pin one source and artifact identity, automate the path, promote
in stages, compare canary/control, and verify after rollout.

Derived applicability rule: canary/control and operational stability gates apply
to staged promotion or deployment. A source/tag or artifact-only endpoint does
not inherit deployment ceremony unless the repository contract couples them.

## Build once, promote immutable artifacts

DORA's deployment-automation guidance describes CI-produced packages in an
artifact repository as deployment input and recommends idempotent, simple,
automated deployment. OCI descriptors use collision-resistant digests as content
identifiers that permit independent integrity verification.

- DORA, "Deployment automation"
  https://dora.dev/capabilities/deployment-automation/
- OCI Image Specification, "Descriptor"
  https://specs.opencontainers.org/image-spec/descriptor/

Derived rule: promote the same digest through environments rather than rebuilding
unidentified variants; verify the digest at the target.

## Provenance and artifact verification

SLSA defines provenance as verifiable information about where, when, and how an
artifact was produced. Its build requirements bind outputs by cryptographic
digest and require consistent build processes; its verification guidance says
provenance must be checked against expectations to provide value.

- SLSA v1.2, "Provenance"
  https://slsa.dev/spec/v1.2/provenance
- SLSA v1.2, "Requirements for producing artifacts"
  https://slsa.dev/spec/v1.2/build-requirements
- SLSA v1.2, "Verifying artifacts"
  https://slsa.dev/spec/v1.2/verifying-artifacts

Derived rule: record source-to-artifact provenance, signatures and SBOMs when
policy requires them, and verify rather than merely generate attestations.

## Versioning follows the product contract

SemVer applies major/minor/patch meaning to a declared public API. CalVer derives
version identifiers from a release calendar. Both are valid contracts; neither is
universal for internal services, mobile builds, or independently versioned
monorepos.

- Semantic Versioning 2.0.0
  https://semver.org/
- Calendar Versioning
  https://calver.org/calendar_versioning.html

Derived rule: use the project's scheme and public contract; an immutable digest
or build ID can be the release identity when no public version exists.

## Tags and releases are policy-specific and collision-sensitive

Git distinguishes lightweight, annotated, and signed tags and refuses an existing
name unless force is requested. GitHub Releases can be drafts and can package
notes/assets; immutable releases lock their tag and assets and generate release
attestation.

- Git documentation, `git tag`
  https://git-scm.com/docs/git-tag.html
- GitHub Docs, "Managing releases in a repository"
  https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository
- GitHub Docs, "Immutable releases"
  https://docs.github.com/en/code-security/concepts/supply-chain-security/immutable-releases

Derived rule: follow the repository's tag type, draft assets before immutable
publication, stop on identity collision, and never force-move a public release tag.

## Human release notes

Keep a Changelog argues that changelogs are for humans and should not be raw VCS
logs; it provides Added, Changed, Deprecated, Removed, Fixed, and Security
categories.

- Keep a Changelog
  https://keepachangelog.com/en/1.1.0/

Derived rule: translate the actual release delta for its audience and separate
public, operator, and restricted security information.

## Continuous delivery and state-compatible migrations

DORA describes continuous delivery as releasing on demand through automated,
low-risk processes. Its database guidance recommends version-controlled,
automated migrations and parallel/expand-contract changes that allow old and new
applications to coexist without database rollback.

- DORA, "Continuous delivery"
  https://dora.dev/capabilities/continuous-delivery/
- DORA, "Database change management"
  https://dora.dev/capabilities/database-change-management/

Derived rule: keep release candidates deployable, prove migration compatibility,
and do not promise binary rollback across irreversible state changes.
