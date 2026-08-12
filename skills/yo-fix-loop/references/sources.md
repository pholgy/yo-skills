# Sources for yo-fix-loop

These sources justify the workflow rules. They are calibration material, not a
required reading list for every invocation.

## Preserve review intent

Google's code-review guidance recommends labeling comments such as required,
nit, optional, and FYI so authors can distinguish blockers from guidance. It
also says technical facts and data should overrule opinions and preferences.

- Google Engineering Practices, "How to write code review comments"
  https://google.github.io/eng-practices/review/reviewer/comments.html
- Google Engineering Practices, "The Standard of Code Review"
  https://google.github.io/eng-practices/review/reviewer/standard.html

Derived rule: record source intent separately from technical validity and do not
silently promote suggestions to blockers.

## Resolve only what is actually addressed

GitHub's review documentation describes resolved, unresolved, and outdated
conversations, and recommends tracking out-of-scope feedback in a linked issue.

- GitHub Docs, "Commenting on a pull request"
  https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/commenting-on-a-pull-request

Derived rule: reconcile every source thread and resolve it only after its claim
is addressed. Create a follow-up issue only when delivery authority permits it.

## Small batches are conceptual, not line quotas

Google defines the right change size as one self-contained change, explicitly
says there are no hard rules, recommends keeping related tests with production
code, and usually separating substantial refactoring from behavior changes.
DORA reports that small batches support faster feedback and that work-in-process
limits help teams finish a small number of high-priority items.

- Google Engineering Practices, "Small CLs"
  https://google.github.io/eng-practices/review/developer/small-cls.html
- DORA, "Working in small batches"
  https://dora.dev/capabilities/working-in-small-batches/
- DORA, "Work in process limits"
  https://dora.dev/capabilities/wip-limits/

Derived rule: work in coherent remediation clusters, limit mutating WIP, and
avoid arbitrary line-count or one-finding-one-commit policy.

## Track ownership, priority, and evidence

Google SRE's postmortem practice requires concrete action items with an owner,
priority, and tracking identifier, and recommends grouping large sets by theme.

- Google SRE Workbook, "Postmortem Culture: Learning from Failure"
  https://sre.google/workbook/postmortem-culture/

Derived rule: retain stable IDs, cluster related work, and require an explicit
owner or next step for deferred items.

The bundle extends that ownership rule to workflow continuity: one domain owns
a cluster at a time, and a specialist handoff returns evidence rather than
restarting the same cluster.

## Severity is not local remediation priority

FIRST's CVSS v4 specification separates intrinsic severity from threat and
environmental context and says organizations need other factors for remediation
decisions. NIST frames patch management as identifying, prioritizing, applying,
and verifying risk responses.

- FIRST, "CVSS v4.0 Specification Document"
  https://www.first.org/cvss/v4-0/specification-document
- NIST SP 800-40 Rev. 4, "Guide to Enterprise Patch Management Planning"
  https://csrc.nist.gov/pubs/sp/800/40/r4/final

Derived rule: reported severity is an input; order work using local impact,
urgency, dependencies, exposure, mitigation, remediation risk, and proof.

## Tests must test the claim

Google's reviewer guidance says tests should be appropriate to the change and
reviewed for whether they would fail when behavior is broken; a test being green
does not by itself establish that it is useful.

- Google Engineering Practices, "What to look for in a code review"
  https://google.github.io/eng-practices/review/reviewer/looking-for.html

Derived rule: bind verification evidence to each finding's acceptance claim and
run combined-wave checks for interactions.

## Independence is a property, not a tone

NASA defines independent verification and validation through technical,
managerial, and financial independence from the development organization.

- NASA Software Engineering Handbook, "SWE-141 - Software Independent
  Verification and Validation"
  https://swehb.nasa.gov/spaces/SWEHBVD/pages/102695499/SWE-141%2B-%2BSoftware%2BIndependent%2BVerification%2Band%2BValidation

Derived rule: a cold self-review is useful but must not be called independent;
route broad or high-risk changes to one genuinely independent read-only audit,
reusing it only while the audited content and material conditions remain equivalent.

## Root-cause completeness without speculative scope

Meta's root-cause-analysis practice distinguishes removing a cause from
repeatedly treating symptoms, while OpenAI describes preparing and validating
the smallest tested fix. Google review guidance adds small, self-contained
changes and useful regression tests. The primary links and policy boundary are
mapped in [the bundle quality standard](../../yo-engineering/references/quality-standard.md).

Derived rule: remove the diagnosed mechanism at the narrowest correct seam,
cover realistic in-scope paths sharing it, add regression proof, and exclude
unrelated cleanup or hypothetical future machinery.
