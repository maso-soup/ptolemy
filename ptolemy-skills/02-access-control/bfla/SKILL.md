---
name: bfla
description: >-
  Exploit broken function-level authorization (API5 / forced browsing to privileged verbs):
  a low-priv or anonymous identity invokes admin/privileged functions. Invoke when
  privileged endpoints/methods exist (from spec or crawl) that lower roles shouldn't reach.
  Tests the function gate, distinct from object-level (BOLA) checks.
family: 02-access-control
type: exploit
owasp: [A01:2021, API5:2023]
cwe: [CWE-285, CWE-862]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# BFLA (Broken Function-Level Authorization)

## Invoke when
- Admin/privileged routes or methods are known (e.g., `/admin/*`, `POST /users/{id}/role`).

## Prerequisites & oracle
- A low-priv/anon session. Oracle = privileged action succeeds without the required role.

## Methodology
1. Enumerate privileged functions (spec diff, JS routes, guessable admin verbs).
2. Replay each with the low-priv/anon session (also try adding/removing role headers).
3. Confirm effect (state change or privileged data), not just non-403 status.
4. Test HTTP-verb variants (GET vs POST vs PUT) — gate may cover only one.

## Starter payloads
- `POST /admin/users`, `DELETE /api/v1/users/{id}`, `PUT /api/settings` with low-priv token;
  toggle `X-Original-URL`/`X-Rewrite-URL` for proxy-gated admin paths.

## False-positive filters
- Endpoint returns 200 but silently no-ops for low-priv → verify actual state change.

## Chains to
- `http-method-tampering`, `path-normalization-bypass`, `mass-assignment`.
