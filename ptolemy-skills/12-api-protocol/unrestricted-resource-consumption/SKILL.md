---
name: api-unrestricted-resource-consumption
description: >-
  Test unrestricted resource consumption (API4/CWE-770/CWE-400): missing pagination caps, no
  rate/size limits, expensive operations reachable cheaply, and cost-amplification (large
  page-size, batch, wildcard, recursive/compute-heavy queries) causing DoS or cost inflation.
  Invoke on endpoints where a small request can trigger large server work. Bounded, careful probing only.
family: 12-api-protocol
type: exploit
owasp: [API4:2023]
cwe: [CWE-770, CWE-400]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Unrestricted Resource Consumption

## Invoke when
- Endpoints accept size/count/complexity parameters or trigger heavy backend work.

## Methodology
1. Identify amplifiers: `limit`/`page_size`, batch arrays, file size, export scope, complex filters.
2. Probe *carefully* whether caps exist (e.g., `limit=100000`, deeply nested GraphQL, large upload).
3. Measure response-time/size growth vs input to show amplification — do NOT sustain a real DoS.
4. Report the missing cap and demonstrated amplification factor.

## Starter payloads
- `?limit=1000000`, oversized upload, GraphQL alias/nesting flood (single bounded probe), zip-bomb-style upload (safe marker).

## False-positive filters
- Enforced caps (server clamps to max) = safe. Never run a sustained flood against shared infra — one bounded proof.

## Chains to
- `api-graphql-abuse`, `rate-limit-bypass`, `finding-writeup`.
