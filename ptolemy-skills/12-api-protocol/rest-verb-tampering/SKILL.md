---
name: api-rest-verb-tampering
description: >-
  Probe REST API method/verb and content-type handling (API5/CWE-650): does the API honor
  unintended verbs (PUT/PATCH/DELETE) or method override on protected resources, accept
  unexpected content types that bypass validation, or expose CRUD not intended for the role.
  Invoke on REST endpoints from the spec/inventory. Complements bfla with API-shape specifics.
family: 12-api-protocol
type: exploit
owasp: [API5:2023]
cwe: [CWE-650, CWE-285]
requires: [scope-guard, api-spec-harvest, evidence-recorder]
authorization: required
---

# REST Verb / Content-Type Tampering

## Invoke when
- REST endpoints are enumerated and per-verb authz/validation may be inconsistent.

## Methodology
1. For each resource, exercise the full CRUD verb set (GET/POST/PUT/PATCH/DELETE/OPTIONS).
2. Test method override (`X-HTTP-Method-Override`, `_method`) against verb-based gates.
3. Swap content types (`application/json` ↔ `application/xml` ↔ form) to bypass validators/enable XXE.
4. Confirm effect (state change / broader access), not just non-error status.

## Starter payloads
- `PUT /api/resource/1`, `DELETE`, `Content-Type: application/xml` on a JSON endpoint (→ XXE check).

## False-positive filters
- 405/404 on unexpected verbs = handled; confirm an actual unauthorized effect.

## Chains to
- `http-method-tampering`, `xxe-attacks`, `bfla`.
