# Sources for yo-deps

These primary and standards sources calibrate the workflow. Current package and
advisory facts must still be checked at invocation time.

## Candidate evaluation and secure acquisition

The OpenSSF evaluation guide covers necessity, authenticity, typosquatting,
maintenance and governance, security practices, API safety, licensing, adoption,
practical behavior testing, indirect dependencies, install scripts, and source
review. NIST's SSDF places supplier and third-party component risk inside the
secure development lifecycle. The OSPS Baseline defines current project-security
controls, including dependency-management policy.

- OpenSSF, "Concise Guide for Evaluating Open Source Software" (2025)
  https://best.openssf.org/Concise-Guide-for-Evaluating-Open-Source-Software.html
- NIST SP 800-218, "Secure Software Development Framework (SSDF) Version 1.1"
  https://csrc.nist.gov/pubs/sp/800/218/final
- OpenSSF, "Open Source Project Security Baseline"
  https://baseline.openssf.org/

Derived rules: evaluate the exact candidate proportionately, verify authentic
identity, combine multiple health signals, inspect execution surface, and retain
an owner for the continuing relationship.

## Graphs, provenance, and dependency review

Open Source Insights builds resolved dependency graphs and exposes versions,
licenses, advisories, Scorecard data, and SLSA attestations, while warning that
metadata and graph calculations have limits. SLSA defines build provenance and
attestation distribution. GitHub dependency review compares direct and indirect
dependency changes between revisions.

- Google Open Source Insights, deps.dev documentation and API
  https://docs.deps.dev/
  https://docs.deps.dev/api/v3/
- SLSA v1.2, "Distributing provenance"
  https://slsa.dev/spec/v1.2/distributing-provenance
- GitHub Docs, "Dependency review"
  https://docs.github.com/en/code-security/concepts/supply-chain-security/dependency-review

Derived rules: review the whole resolved graph, inspect material transitive
changes and build-time execution, and treat provenance as useful evidence rather
than a universal pass/fail gate.

## Reuse versus local implementation

Google's dependency-management chapter argues both that reuse avoids costly
reimplementation and that external dependencies create a long-lived contract in
a changing network. It explicitly describes SemVer as a lossy estimate and
downstream tests as higher-fidelity evidence.

- Google, "Software Engineering at Google," Chapter 21: Dependency Management
  https://abseil.io/resources/swe-book/html/ch21.html

Derived rule: do not use a line-count threshold. Compare correctness, security,
network complexity, compatibility promises, and lifetime maintenance.

## Versions and compatibility units

SemVer defines what major, minor, and patch numbers intend to communicate, while
also warning about constraints that are too tight or too loose. Renovate's
official guidance supports grouping related monorepo packages and warns that
overly wide groups become hard to maintain.

- Semantic Versioning 2.0.0
  https://semver.org/
- Renovate Docs, "Noise Reduction"
  https://docs.renovatebot.com/noise-reduction/
- Renovate Docs, "Pull requests"
  https://docs.renovatebot.com/key-concepts/pull-requests/

Derived rules: read the full release span, verify behavior instead of trusting
the number, group lockstep compatibility sets, and separate unrelated changes
when that improves attribution.

## Ecosystem-native reproducibility

Different ecosystems encode reproducibility differently. npm's lockfile records
an exact tree; Cargo advises checking `Cargo.lock` into version control when in
doubt; Go uses `go.mod` for version selection and `go.sum` for authenticated
content; pip supports pinned and hash-checked repeatable installs.

- npm Docs, "package-lock.json"
  https://docs.npmjs.com/cli/v11/configuring-npm/package-lock-json/
- Cargo Book, "Cargo.toml vs Cargo.lock"
  https://doc.rust-lang.org/cargo/guide/cargo-toml-vs-cargo-lock.html
- Go Modules Reference
  https://go.dev/ref/mod
- pip Docs, "Repeatable Installs"
  https://pip.pypa.io/en/latest/topics/repeatable-installs/

Derived rule: follow the repository and ecosystem's native manifest,
resolution, checksum, and frozen-install model instead of assuming every project
has the same lockfile policy.

## Advisory precision and risk-based prioritization

OSV maps advisories to package ecosystems and exact version or commit ranges.
FIRST states that CVSS Base is severity rather than complete risk; EPSS estimates
exploitation probability and is only one threat input. CISA KEV records evidence
of active exploitation.

- OSV.dev documentation and API
  https://google.github.io/osv.dev/
  https://google.github.io/osv.dev/api/
- FIRST, "CVSS v4.0 Specification Document"
  https://www.first.org/cvss/v4-0/specification-document
- FIRST, "EPSS User Guide"
  https://www.first.org/epss/user-guide
- CISA, "Known Exploited Vulnerabilities Catalog"
  https://www.cisa.gov/known-exploited-vulnerabilities-catalog

Derived rules: confirm the installed path and affected range, distinguish
presence from reachable exposure, prioritize from local impact plus threat
evidence, and prove removal or containment after remediation.

## License identifiers are data, not legal conclusions

SPDX standardizes license identifiers and expressions. deps.dev explicitly warns
that its package metadata is not legal advice and may be incomplete.

- SPDX, "Handling License Info"
  https://spdx.dev/learn/handling-license-info/
- deps.dev API license notes
  https://docs.deps.dev/api/v3/

Derived rule: compare exact-version and transitive license information with the
repository's policy, verify unknowns, and escalate legal conclusions rather than
inventing them.
