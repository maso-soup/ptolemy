---
name: path-normalization-bypass
description: >-
  Bypass ACLs enforced at a proxy/gateway but not the app (or vice-versa) via path
  normalization discrepancies: `..;/`, `%2e%2e`, trailing dots/slashes, `/./`, case,
  duplicated slashes, and `X-Original-URL`/`X-Rewrite-URL` header routing. Invoke when a
  path is denied (401/403/404) at one layer and you suspect a different layer would allow it.
family: 02-access-control
type: exploit
owasp: [A01:2021, A05:2021]
cwe: [CWE-22, CWE-436]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Path Normalization / ACL Bypass

## Invoke when
- A privileged path returns 401/403/404 and a proxy+app stack is present.

## Prerequisites & oracle
- Oracle = the same logical resource becomes reachable via an equivalent-but-differently-
  normalized path.

## Methodology
1. Baseline the denied path.
2. Apply normalization variants and compare (see payloads).
3. Try override headers (`X-Original-URL`, `X-Rewrite-URL`, `X-Forwarded-Path`).
4. Confirm you reached the *protected* resource, not a 404 lookalike.

## Starter payloads
- `/admin` → `/admin/`, `/admin/.`, `/./admin`, `/%2e/admin`, `/admin%20`, `/admin..;/`,
  `/APP/../admin`, `//admin`, `/admin?`; headers: `X-Original-URL: /admin`.

## False-positive filters
- 200 from a generic catch-all/SPA index ≠ reaching the protected handler. Verify content.

## Chains to
- `bfla`, `forced-browsing`, `http-request-smuggling` (front/back desync).
