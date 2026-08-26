---
name: mass-assignment
description: >-
  Exploit property-level authorization / over-posting (API6, CWE-915): submit extra object
  properties the client shouldn't control (is_admin, role, balance, verified, price) and the
  backend binds them. Invoke on create/update endpoints with object bodies, especially where
  the read model exposes fields the write model shouldn't accept.
family: 02-access-control
type: exploit
owasp: [A01:2021, API3:2023]
cwe: [CWE-915, CWE-639]
requires: [scope-guard, parameter-mining, evidence-recorder]
authorization: required
---

# Mass Assignment / Over-posting

## Invoke when
- A write endpoint deserializes a body into a model (JSON/form) and privileged fields exist.

## Prerequisites & oracle
- Knowledge of privileged field names (from GET responses, spec, or JS). Oracle = the
  privileged field's value changes as submitted.

## Methodology
1. Read the object → harvest all field names, incl. ones the UI never sends.
2. On update/create, inject privileged fields (`role`, `is_admin`, `verified`, `owner_id`,
   `price`, `credits`) at top level and nested.
3. Re-read to confirm the field was bound.
4. Try type/shape tricks (array vs scalar, nested object) to bypass naive allowlists.

## Starter payloads
- `{"email":"x","role":"admin"}`, `{"...":"...","is_admin":true}`, `{"user":{"id":42}}`.

## False-positive filters
- Field echoed in response but not persisted → re-fetch in a fresh request to confirm binding.

## Chains to
- `idor-bola`, `bfla`, `auth-*` (privilege escalation), `chain-builder`.
