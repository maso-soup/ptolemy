---
name: evidence-recorder
description: >-
  Normalizes every confirmed finding into a reproducible evidence record. Invoke the moment
  a triage/exploit skill confirms a hit, to capture the exact request/response, the oracle
  that proved it, minimal PoC, and CWE/OWASP mapping — before moving on. Feeds the report
  skills and dedupes repeat findings.
family: 00-orchestration
type: orchestration
owasp: []
cwe: []
requires: []
authorization: required
---

# Evidence Recorder

## Invoke when
- Any skill confirms a vulnerability (oracle fired, PoC works).

## Methodology
1. Capture raw HTTP request + response (redact secrets not needed for repro).
2. Record the discriminating oracle (diff/timing/OAST hit) that proves causation.
3. Store minimal reproducible PoC + affected {endpoint, param, role}.
4. Tag CWE + OWASP category + provisional CVSS vector.
5. Dedupe against existing records (same root cause across endpoints → one issue, N instances).

## Chains to
- `finding-writeup` — turn the record into the report entry.
