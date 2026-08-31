---
name: access-control-triage
description: >-
  Entry point for broken access control (OWASP A01 / API1/3/5). Invoke when you hold ≥1
  session or can compare roles/anonymous access, to decide which access-control exploit
  applies: object-level (IDOR/BOLA), function-level (BFLA), property-level (mass assignment),
  method/verb, path-normalization, or tenant isolation. Diffs low-priv vs high-priv surface.
family: 02-access-control
type: triage
owasp: [A01:2021, API1:2023, API5:2023]
cwe: [CWE-284, CWE-285]
requires: [crawler-authenticated]
authorization: required
---

# Access Control Triage

## Invoke when
- You can act as ≥1 identity (anon, low-priv, high-priv, or two peers) against the same app.

## Methodology
1. Assemble per-role endpoint sets (from `crawler-authenticated`).
2. Identify object references (IDs, UUIDs, filenames) → candidate `idor-bola`.
3. Identify privileged functions reachable by forced browsing → candidate `bfla`.
4. Identify write endpoints with rich bodies → candidate `mass-assignment`.
5. Note routing/ACL layering (proxy vs app) → candidate `path-normalization-bypass`.
6. Route each candidate to its exploit skill with the specific vector.

## False-positive filters
- A 403 at proxy but 200 at app (or vice-versa) is the *signal*, not a false positive.

## Chains to
- `idor-bola`, `bfla`, `mass-assignment`, `http-method-tampering`, `path-normalization-bypass`, `multi-tenant-isolation`, `forced-browsing`.
