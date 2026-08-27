---
name: chain-narrative
description: >-
  Narrate a multi-step exploit chain into a single high-impact story for the report: how
  individually-scored findings compose from attacker-start to a critical outcome (RCE, full
  account/tenant takeover, mass data exfil), with the trust boundary crossed at each hop and the
  aggregate severity. Invoke once an end-to-end path across ≥2 confirmed findings has been demonstrated.
family: 14-report
type: report
owasp: []
cwe: []
requires: [finding-writeup]
authorization: required
---

# Chain Narrative

## Invoke when
- A multi-step chain across ≥2 confirmed findings has been demonstrated end-to-end.

## Methodology
1. Order the constituent findings as the demonstrated attack path.
2. For each hop: precondition met, action, capability gained, trust boundary crossed.
3. State the aggregate impact and why the chain's severity exceeds the max individual finding.
4. Include the reproducible end-to-end sequence and a clear remediation that breaks the chain
   (identify the single cheapest link to fix).
