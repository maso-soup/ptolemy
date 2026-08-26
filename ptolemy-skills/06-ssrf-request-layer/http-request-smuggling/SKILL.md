---
name: http-request-smuggling
description: >-
  Exploit HTTP request smuggling / desync (CWE-444): front-end and back-end disagree on request
  boundaries via Content-Length vs Transfer-Encoding (CL.TE, TE.CL, TE.TE) or HTTP/2 downgrade,
  enabling request poisoning, auth bypass, and cache poisoning. Invoke on multi-tier setups
  (CDN/LB + origin). Timing-based CL.TE probe first; validate carefully to avoid poisoning others.
family: 06-ssrf-request-layer
type: exploit
owasp: [A05:2021]
cwe: [CWE-444]
requires: [scope-guard, util-timing-oracle, evidence-recorder]
authorization: required
---

# HTTP Request Smuggling

## Invoke when
- A front-end proxy/CDN sits before an origin (header rewriting, connection reuse present).

## Methodology
1. Detect with timing probes (CL.TE / TE.CL) that delay only on a desync — Burp's technique.
2. Confirm with a differential (smuggle a prefix that changes the *next* response) using your own
   follow-up request to avoid impacting other users.
3. Escalate: capture others' requests, bypass front-end authz, poison the cache.
4. HTTP/2: test h2.CL/h2.TE downgrade smuggling.

## Starter payloads
- CL.TE / TE.CL header pairs with obfuscated `Transfer-Encoding` (` chunked`, `chunked\t`, dup TE).

## False-positive filters
- Network jitter mimics desync timing — require the confirmed request-prefix effect, not just delay.
- Be conservative: never run poisoning that would hit real users' sessions.

## Chains to
- `web-cache-poisoning`, `path-normalization-bypass`, `chain-builder`.
