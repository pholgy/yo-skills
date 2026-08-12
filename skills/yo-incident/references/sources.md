# Sources for yo-incident

These sources justify the command, mitigation, recovery, security, and learning
rules. Organization-specific runbooks and legal obligations remain authoritative.

## Command, roles, and live state

Google SRE defines Incident Command, Operations, Communications, and Planning;
keeps a recognized command post and live document; limits production operations
to the operations group; and requires explicit role handoff. The SRE Workbook
distills the model into command, communication, and control.

- Google SRE Book, "Managing Incidents"
  https://sre.google/sre-book/managing-incidents/
- Google SRE Workbook, "Incident Response"
  https://sre.google/workbook/incident-response/
- Google SRE, "Incident Management Guide"
  https://sre.google/resources/practices-and-processes/incident-management-guide/

Derived rules: declare early, name IC/Ops/Comms/Scribe hats even in a small
response, centralize mutations, keep one live state, and hand off explicitly.

## Response is a lifecycle, not rollback alone

NIST SP 800-61 Rev. 3 integrates detection, response, recovery, communication,
and improvement into cybersecurity risk management. It supersedes the 2012
revision and is the current NIST incident-response recommendation.

- NIST SP 800-61 Rev. 3, "Incident Response Recommendations and Considerations
  for Cybersecurity Risk Management" (2025)
  https://csrc.nist.gov/pubs/sp/800/61/r3/final

Derived rule: distinguish declaration, containment, recovery, resolution, and
post-incident improvement; security incidents need their own response path.
Verified resolution ends the incident endpoint. Preserve evidence for later
learning, but do not automatically launch that separate work unless the user's
request, organization policy, or incident owner includes it.

## Containment must consider evidence and business impact

CISA's incident playbook and ransomware guide cover detection/analysis,
containment, eradication, recovery, evidence preservation, coordinated isolation,
out-of-band communication, leadership updates, and notification plans. CISA
warns that powering down can destroy volatile evidence and that partial action can
alert an adversary.

- CISA, "Federal Government Cybersecurity Incident and Vulnerability Response
  Playbooks"
  https://www.cisa.gov/sites/default/files/publications/Cybersecurity_Incident_Vulnerability_Response_Playbooks_508C.pdf
- CISA, "StopRansomware Guide"
  https://www.cisa.gov/stopransomware/ransomware-guide

Derived rules: stop active harm, preserve restricted evidence where compatible,
coordinate security/legal/privacy communications, and sequence eviction rather
than applying availability-only rollback habits.

## Rollback requires compatibility

Amazon's rollback-safety guidance uses two-phase deployment and serialization
compatibility to keep old and new versions safe during rollback. AWS database
migration guidance shows that fallback can lose writes and may require dual write,
replication, or roll-forward architecture.

- Amazon Builders' Library, "Ensuring rollback safety during deployments"
  https://aws.amazon.com/builders-library/ensuring-rollback-safety-during-deployments/
- AWS Database Blog, "Rolling back from a migration with AWS DMS"
  https://aws.amazon.com/blogs/database/rolling-back-from-a-migration-with-aws-dms/

Derived rule: a previous artifact is not automatically safe against current
schema or state; validate migration, writes, protocol, and replay compatibility.

## User-visible and system recovery signals

Google SRE distinguishes black-box monitoring of externally visible behavior from
white-box internals and identifies latency, traffic, errors, and saturation as
core signals. Its monitoring workbook warns that observation delay can create
false causal conclusions during response.

- Google SRE Book, "Monitoring Distributed Systems"
  https://sre.google/sre-book/monitoring-distributed-systems/
- Google SRE Workbook, "Monitoring"
  https://sre.google/workbook/monitoring/

Derived rules: verify user behavior plus system/data/security invariants, and
wait for signal propagation before judging a mitigation.

For network and security-policy mutations, the bundle makes that proof explicit:
use a representative canary, expected-allow and expected-deny probes, capacity
signals, and a named production operator rather than inferring recovery from one
successful request.

For cross-provider access deactivation, incident containment hands the same
authority, identity, generation, idempotency, and reconciliation evidence into
one scoped implementation-and-audit chain. This prevents both unsafe design-only
closure and a duplicate rediscovery cycle.

## Communications cadence and role separation

PagerDuty's public incident-response process gives the IC, scribe, operations,
customer liaison, and support roles distinct duties. Its anti-pattern guidance
describes periodic updates while cautioning that excessive updates steal time
from response.

- PagerDuty Incident Response, "Different Roles"
  https://response.pagerduty.com/before/different_roles/
- PagerDuty Incident Response, "Anti-Patterns"
  https://response.pagerduty.com/resources/anti_patterns/

Derived rule: the communications owner shields operators and sets an explicit
organization-appropriate next update, rather than a universal hardcoded cadence.

## Blameless, actionable learning

Google's postmortem guidance requires factual impact, causal depth, blameless
systems framing, review, and concrete action items with owner, priority, tracking
record, and measurable outcome. It also warns against including identifying user
information in postmortems.

- Google SRE Workbook, "Postmortem Culture: Learning from Failure"
  https://sre.google/workbook/postmortem-culture/
- Google SRE Book, "Postmortem Culture: Learning from Failure"
  https://sre.google/sre-book/postmortem-culture/

Derived rule: separate mitigation from permanent correction, review the response
as well as the bug, protect sensitive data, and track owned corrective work to
completion.
