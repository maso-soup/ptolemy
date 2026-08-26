---
name: finding-writeup
description: >-
  Convert a confirmed finding (from evidence-recorder) into a complete, standards-mapped report
  entry: title, affected asset, CWE + OWASP category, CVSS v3.1/v4.0 vector & score, reproduction
  steps, impact, and remediation. Invoke once per verified vulnerability when documenting results.
  Enforces reproducibility and severity discipline; refuses to write up unverified/oracle-less claims.
family: 14-report
type: report
owasp: []
cwe: []
requires: [evidence-recorder]
authorization: required
---

# Finding Write-up

## Invoke when
- A finding is confirmed (oracle fired + reproducible PoC captured) and needs documentation.

## Methodology
1. Pull the evidence record (request/response, oracle, minimal PoC, affected {endpoint,param,role}).
2. Map CWE + OWASP (Web A0x / API x) and compute a CVSS vector with justification per metric.
3. Write reproducible steps a third party can follow from scratch.
4. State concrete impact (what an attacker gains) and precise, actionable remediation.
5. Grade confidence; keep PoC bounded (no gratuitous data dumps).

## False-positive filters
- Do NOT write up a finding lacking a confirmed oracle or reproducible PoC — send it back for verification.

## Chains to
- `chain-narrative` (if part of a chain).
