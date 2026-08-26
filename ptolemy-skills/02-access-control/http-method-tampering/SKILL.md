---
name: http-method-tampering
description: >-
  Bypass authorization by changing the HTTP verb or tunneling it: try HEAD/PUT/PATCH/DELETE/
  arbitrary methods and `X-HTTP-Method-Override`/`_method` when a gate only protects GET/POST.
  Invoke when an action is denied under one verb but the framework may honor another.
family: 02-access-control
type: exploit
owasp: [A01:2021, API5:2023]
cwe: [CWE-650, CWE-285]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# HTTP Method Tampering

## Invoke when
- An endpoint's authz appears verb-specific, or the framework supports method override.

## Methodology
1. Baseline the protected action under its normal verb.
2. Replay with HEAD/OPTIONS/PUT/PATCH/DELETE and an arbitrary token method (`FOO`).
3. Add override channels: header `X-HTTP-Method-Override: PUT`, body `_method=DELETE`.
4. Confirm the action executed (state change), not merely a different status.

## Starter payloads
- `PUT /api/users/1`, `X-HTTP-Method-Override: DELETE`, `_method=PATCH`.

## False-positive filters
- Many servers 200 on HEAD with no body — confirm effect, not response emptiness.

## Chains to
- `bfla`, `path-normalization-bypass`.
