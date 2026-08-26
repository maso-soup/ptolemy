---
name: parameter-mining
description: >-
  Discover hidden/undocumented parameters an endpoint honors but doesn't advertise (query,
  body, JSON keys, headers). Invoke per endpoint before injection/logic testing — hidden
  params (debug=, admin=, redirect=, unsafe JSON keys) are frequently the vulnerable input.
  Uses response-diffing to confirm a param is actually processed.
family: 01-recon
type: recon
owasp: []
cwe: [CWE-233]
requires: [scope-guard, util-differential-oracle]
authorization: required
---

# Parameter Mining

## Invoke when
- An endpoint is identified and you need its full accepted-input surface.

## Methodology
1. Baseline the endpoint response (via `util-differential-oracle`).
2. Fuzz candidate param names (common + wordlist + spec-derived) in query/body/JSON/headers.
3. Keep params that change the response (reflected value, length delta, status, timing).
4. Note candidate high-risk names: `redirect`, `url`, `file`, `debug`, `role`, `is_admin`.

## False-positive filters
- Rate-limit/caching artifacts mimic diffs — confirm with repeat + control requests.

## Chains to
- `injection-reflection-triage`, `authz-mass-assignment`, `ssrf-triage`, `open-redirect`.
