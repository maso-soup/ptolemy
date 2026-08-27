---
name: idor-bola
description: >-
  Exploit object-level authorization failures (IDOR / API BOLA, CWE-639): access or modify
  another user's object by tampering an identifier. Invoke when an endpoint takes an object
  reference (numeric id, UUID, filename, hash, encoded id) and you have a second identity or
  known peer object. Confirms via cross-account retrieval, not just a 200.
family: 02-access-control
type: exploit
owasp: [A01:2021, API1:2023]
cwe: [CWE-639, CWE-566]
requires: []
authorization: required
---

# IDOR / BOLA

## Invoke when
- A request references an object by id/uuid/filename/hash and identity is inferred from session.

## Prerequisites & oracle
- Two identities (A, B) OR one identity + a known object owned by another user. Oracle = A's
  session returns B's object data (or successfully mutates it).

## Methodology
1. Capture A's request for A's object; note the reference param.
2. Substitute B's reference (adjacent id, enumerated UUID, decoded/re-encoded id).
3. Compare responses: A-session returning B-data = confirmed.
4. Test read → then bounded write (only non-destructive fields) to grade impact.
5. Check indirect refs (hashed/encoded ids) for predictability.

## Starter payloads
- `GET /api/orders/1001` → `1002,1000,999`; `/files/{uuid}` → enumerated/leaked uuids;
  base64/`hashids`-decoded ids incremented then re-encoded.

## False-positive filters
- Same data because both users legitimately share it (public object) → not IDOR.
- 200 with empty/authorized-scoped body → not a leak. Compare actual object ownership.

## Evidence to capture
- A-session request + B-owned data returned; the id transformation used.
