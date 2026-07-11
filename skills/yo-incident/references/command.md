# Incident command and record templates

Use the organization's incident system when available. These templates are
fallback structures, not instructions to create repository files or public posts.

## Live state header

```markdown
Incident ID / status:
Severity scheme and current level:
Declared / detected / earliest impact time (timezone):
IC / Ops / Comms / Scribe:
Primary and out-of-band channels:

Confirmed user and business impact:
Affected / unaffected scope:
Data, security, privacy, financial, or safety risk:
Current black-box and service signals:

Last known good:
Recent relevant changes:
Active hypotheses:
Mitigations attempted and outcomes:
Current production deviations / freeze:

Recovery criteria and stability window:
Current blockers / decisions needed:
Next internal update:
Next authorized stakeholder update:
```

Keep the most important current state at the top. Historical detail belongs in
the append-only timeline.

## Timeline row

```markdown
<absolute time + timezone> | <actor/role> | observation | hypothesis | decision |
action | expected signal / abort condition | actual result | evidence reference
```

Not every row needs every field. Distinguish event time, observation time, and
entry time when they differ. Append corrections instead of editing history. Use
one synchronized time source when possible.

Redact credentials, access tokens, personal data, customer payloads, exploit
details, and restricted infrastructure. Store evidence in the approved restricted
system and reference its stable identifier.

## Role boundaries

- **Incident Commander** - owns priorities, roles, incident state, escalation,
  decision log, and closure criteria. Does not become the default terminal operator
  when staffing permits.
- **Operations Lead** - controls production mutations, delegates operators, and
  reports expected and actual results to command.
- **Communications Lead** - maps audiences, obtains approvals, maintains cadence,
  and shields operators from inbound status requests.
- **Scribe/Planning** - maintains timeline, tracks decisions and system
  deviations, prepares handoff, and captures follow-up candidates.
- **Subject-matter responder** - investigates an assigned hypothesis read-only by
  default and returns evidence, not independent production changes.

The IC assumes any unassigned role explicitly. For a solo response, write which
hat is active before changing from investigation to operation or communication.

## Command handoff

The outgoing role states:

- current impact/status and latest signals;
- actions taken, current deviations, and outcomes;
- active hypotheses and disconfirmed paths;
- hazards, authority limits, and pending approvals;
- current operator tasks and abort conditions;
- next communication and recovery criteria.

The incoming role repeats the critical state and explicitly accepts. Announce the
handoff to responders and record its time.

## Internal update

```markdown
Status: <investigating | mitigating | monitoring | recovered, or org terms>
Impact: <confirmed users/functions/time window>
Current state: <facts, not causal speculation>
Action: <mitigation underway or completed + observed result>
Unknowns: <material open question>
Next update: <time or trigger>
```

## External/customer update

Use only through the authorized communications owner and status process.

```markdown
We are investigating <plain-language affected capability> beginning at <time>.
<Confirmed user impact and any safe workaround.>
<Current mitigation or recovery status without sensitive detail.>
Next update: <time>.
```

Do not expose internal topology, exploit details, customer identifiers, uncertain
root cause, or promises the response team cannot guarantee.
