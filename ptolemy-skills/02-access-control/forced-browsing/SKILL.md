---
name: forced-browsing
description: >-
  Reach unlinked-but-live privileged resources by direct request (no ACL relies on
  obscurity): admin consoles, staging endpoints, export/download routes, backup artifacts.
  Invoke when content-discovery or spec analysis reveals resources gated only by "not
  linked". Complements bfla (which targets known privileged functions).
family: 02-access-control
type: exploit
owasp: [A01:2021]
cwe: [CWE-425, CWE-862]
requires: [scope-guard, content-discovery, evidence-recorder]
authorization: required
---

# Forced Browsing

## Invoke when
- Discovery/spec suggests privileged resources that may lack real authz (security-by-obscurity).

## Methodology
1. Compile candidate privileged URLs (admin, debug, export, internal, versioned).
2. Request directly as anon/low-priv.
3. Confirm privileged content/action returned (not a redirect to login).
4. Grade by data sensitivity / action power.

## False-positive filters
- Redirect (302) to login = gated. Only count served privileged content/effect.

## Chains to
- `bfla`, `config-debug-endpoint-exposure`, `config-default-creds-exposed-panels`.
