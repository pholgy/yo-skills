# Research and decisions

Use this file when maintaining or auditing `yo-verify-premise`.

## Evidence-to-rule map

| Verification rule | Evidence | Decision |
|---|---|---|
| Treat a problem report as the start of an investigation | Google SRE models troubleshooting as observations plus hypotheses tested against system knowledge and telemetry. | Restate a falsifiable claim and seek confirming or disconfirming evidence. |
| Capture expected, actual, reproduction, and environment | Google SRE, GitHub issue forms, Mozilla's bug-writing guidance, and Bettenburg et al. identify these as high-value report information. | Bind the claim to conditions and target state before judging it. |
| Prefer reproducible, discriminating tests but account for confounders | Google SRE recommends reproducible cases, tests that rule hypotheses in or out, likelihood/risk ordering, and explicit attention to confounding factors. | Choose the cheapest decisive check and record its limits. |
| Understand the system and connected flow | Google SRE stresses system knowledge, telemetry, data flow, and divide-and-conquer examination; Google review guidance starts with whether the change makes sense before reviewing detail. | Search to locate, then read enough connected code to explain the behavior; remove arbitrary line/full-file quotas. |
| Do not overclaim negative results | Google SRE notes that some experiments are only suggestive and production failures may be difficult or unsafe to reproduce. | Separate "not reproduced" from "disproved" and add an insufficient-evidence verdict. |
| Verify current applicability of existing evidence | Mozilla recommends checking current builds because the bug may already be fixed; version and environment are core report fields. | Reuse credible evidence, but bind it to the current revision instead of treating "already verified" as a blanket exemption. |
| Separate observation from speculation | Mozilla explicitly distinguishes actual/expected observations from speculation; Google SRE separates symptoms, hypotheses, and root cause. | Track symptom and cause independently and route unknown causes to `yo-debug`. |

## Authoritative sources

- Google SRE, [Effective Troubleshooting](https://sre.google/sre-book/effective-troubleshooting/)
- Google Engineering Practices, [Navigating a CL in review](https://google.github.io/eng-practices/review/reviewer/navigate.html)
- GitHub Docs, [Syntax for issue forms](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-issue-forms)
- Mozilla Bugzilla, [Bug Writing Guidelines](https://bugzilla.mozilla.org/page.cgi?id=bug-writing.html)
- Bettenburg et al., [What makes a good bug report?](https://doi.org/10.1145/1453101.1453146), FSE 2008.

## Keep / improve / move / remove

### Keep

- Verify before changing product code.
- Trace the real behavior rather than trusting a cited line or proposed fix.
- Surface changed or wider scope instead of silently redefining the task.
- Hand unknown cause to `yo-debug` and blast-radius analysis to `yo-impact`.
- Produce a compact evidence artifact for later audit.

### Improve

- Bind every claim and result to revision, environment, and conditions.
- Reuse credible prior reproduction without assuming it applies forever.
- Require a current trace or behavior check before treating a fix-looking
  commit, guard, or closed issue as proof of resolution.
- Separate symptom, cause, impact, and proposed fix.
- Reserve `known cause` for a mechanism that explains the important conditions
  and justifies the next intervention, not merely the closest failing boundary.
- Add `not reproduced` and `insufficient evidence` instead of treating every
  failed reproduction as a broken premise.
- Inspect available issue, PR, repository, and runtime state before asking the
  user for information that is already discoverable.

### Move

- Move evidence selection, strength, and verdict semantics to
  `evidence-model.md`.
- Leave root-cause work, impact analysis, implementation, and GitHub prose in
  their owning Yo skills.

### Remove

- Remove the unsupported claim that roughly one in three reports is wrong.
- Remove the 58-percent comprehension statistic because it does not justify a
  verification procedure.
- Remove mandatory full-file and 30-line reading quotas.
- Remove "the user already verified" as a complete exemption.
- Remove automatic GitHub posting as an implied endpoint.

## Classification notes

- Hypothesis testing, reproducibility, environment matching, and calibrated
  negative results are research-backed investigation practices.
- Treating live repository and GitHub state as authoritative before action is
  also an explicit user workflow preference.
- The exact verdict labels and bundle handoffs are local Yo policy.
- Verification evidence does not itself authorize an external write.
