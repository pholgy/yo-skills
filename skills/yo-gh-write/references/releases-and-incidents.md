# Release, incident, and security templates — yo-gh-write

Use release text for users and operators, not as a commit dump. Use incident text to communicate facts, impact, recovery, and owned follow-up without blame.

## Contents

- [Release notes](#release-notes)
- [Release correction](#release-correction)
- [Incident recovery update](#incident-recovery-update)
- [Incident progress update](#incident-progress-update)
- [Postmortem](#postmortem)
- [Private security advisory](#private-security-advisory)

## Release notes

```markdown
## Highlights

- <Most important user-visible improvement>

## Changes

- <Feature or behavior change>

## Fixes

- <User-visible correction>

## Breaking changes

<Impact and migration steps, or `None`.>

## Upgrade notes

<Required operator or user action, or omit when none.>

## Known issues

<Known limitation and workaround, or `None`.>

**Full changelog:** <comparison link>
```

Generate the merged-PR list when useful, then curate it. Group by user impact, remove internal-only noise, verify version numbers and links, and never hide a breaking change in a generic bullet.

## Release correction

```markdown
## Correction

<What was wrong in the original notes>

Correct behavior or requirement: <accurate statement>.

Affected version: `<version>`.
```

Do not silently rewrite a material published claim without a visible correction under the repository's convention.

## Incident recovery update

```markdown
## Recovery update

**Resolved at <timestamp and timezone>.**

Impact: <users, systems, and duration affected>.

Mitigation: <what restored service>.

Verification: <user-visible flow and monitoring result>.

Follow-up: #<postmortem or action-item issue>.
```

If service is only partially restored, say `Mitigated` rather than `Resolved` and name the remaining impact.

## Incident progress update

```markdown
## Incident update — <timestamp and timezone>

Status: <investigating / identified / monitoring / mitigated>.

Impact: <current user-visible impact>.

Current action: <mitigation or diagnostic step>.

Next update: <time or completion condition>.
```

Do not speculate about root cause during live response. Separate confirmed facts from hypotheses.

## Postmortem

```markdown
## Summary

<What happened and how it was detected>

## Impact

<Users, duration, and measurable effect>

## Timeline

| Time | Event |
|---|---|
| <time> | <fact> |

## Root cause

<Technical mechanism without blame>

## Resolution

<How service was restored>

## Contributing factors

- <Condition>

## What went well

- <Useful control or response behavior>

## What went poorly

- <System or process gap stated without blame>

## Action items

| Owner | Action | Due |
|---|---|---|
| <one owner> | <verifiable action> | <date> |
```

Use verifiable data instead of dramatic language. Give each action one accountable owner and a completion condition.

## Private security advisory

Never post vulnerability details in a public issue before coordinated disclosure. Read `SECURITY.md` and use GitHub private vulnerability reporting or a draft repository security advisory.

```markdown
## Summary

<Concise vulnerability description>

## Affected products and versions

- <package/product and version range>

## Impact

<Attacker capability, required access, and affected confidentiality,
integrity, or availability>

## Reproduction

<Minimal private steps or proof of concept>

## Remediation

<Patch and fixed version, or current plan>

## Workaround

<Mitigation for affected users, or `None known`.>

## Disclosure timeline

| Date | Event |
|---|---|
| <date> | <private report, acknowledgement, fix, or publication> |

## Credit

<Reporter and contributors, subject to consent>
```

If no private reporting route exists, create only a minimal public request for a security contact; do not include exploitability or reproduction details.

Standards basis: GitHub release-note and repository-security-advisory guidance plus Google SRE postmortem practices. See `sources.md`.
