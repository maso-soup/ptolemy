---
name: util-waf-bypass
description: >-
  Shared payload-mutation engine for evading WAFs/input filters. Invoke from any injection/XSS
  skill when a payload is blocked (403/challenge/generic block page) but the underlying vuln is
  suspected. Applies encoding, case/whitespace/comment obfuscation, chunking, parameter pollution,
  and known vendor bypasses, then hands the surviving payload back. A dependency, not a standalone attack.
family: 13-util-evasion
type: util
owasp: []
cwe: []
requires: [scope-guard]
authorization: required
---

# WAF / Filter Bypass (util)

## Invoke when
- A skill's payload is blocked by a WAF/filter but the vuln likely exists behind it.

## Methodology
1. Confirm it's the WAF (not the app) blocking — fingerprint the block page/headers.
2. Apply transforms progressively: URL/double-URL/unicode/HTML encoding; case toggling; inline
   comments (`/**/`, `--`); whitespace alternatives (`%09%0a%0c`); keyword splitting; nested/overlong.
3. Structural: HTTP parameter pollution, JSON/array coercion, content-type swap, chunked bodies.
4. Vendor-specific known bypasses keyed on the fingerprint.
5. Return the minimal surviving payload to the caller skill.

## Starter transforms
- `UNION`→`UN/**/ION`, `SELECT`→`sElEcT`, `<script>`→`<sCr%00ipt>`, `' OR '1'='1`→`'/**/OR/**/'1'='1`,
  `?id=1&id=payload` (HPP), full-width unicode, double-encoding.

## False-positive filters
- A payload that "passes" the WAF but the app still rejects = app-level filtering, not the vuln being absent.

## Chains to
- returns control to the calling injection/XSS skill.
