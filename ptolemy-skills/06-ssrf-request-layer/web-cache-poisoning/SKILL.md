---
name: web-cache-poisoning
description: >-
  Exploit web cache poisoning (CWE-444/CWE-349): get a harmful response cached under a key
  other users share, via unkeyed inputs (headers like X-Forwarded-Host, X-Forwarded-Scheme,
  unkeyed query params) that influence the response. Invoke when a cache (CDN/reverse proxy) is
  present and unkeyed inputs reflect into cacheable responses. Impact: stored XSS/redirect at scale.
family: 06-ssrf-request-layer
type: exploit
owasp: [A05:2021]
cwe: [CWE-444, CWE-349]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Web Cache Poisoning

## Invoke when
- A cache fronts the app and some inputs affect responses without being in the cache key.

## Methodology
1. Identify cache behavior (Age/X-Cache headers, hit/miss).
2. Find unkeyed inputs that reflect (headers: `X-Forwarded-Host/Scheme/For`, `X-Host`, params).
3. Poison a cacheable resource so the malicious value is served to subsequent users.
4. Demonstrate on a benign marker path; do NOT poison high-traffic real pages.

## Starter payloads
- `X-Forwarded-Host: attacker.tld` reflected into a cached `<script src>`/redirect;
  unkeyed `?utm=...` reflected into cached HTML.

## False-positive filters
- Reflection in a non-cached (private/no-store) response ≠ poisoning; confirm it's actually cached and shared.

## Chains to
- `xss-context-triage`, `open-redirect`, `host-header-attacks`, `http-request-smuggling`.
