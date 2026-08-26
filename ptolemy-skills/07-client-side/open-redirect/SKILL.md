---
name: open-redirect
description: >-
  Exploit open redirection (CWE-601): a redirect target is attacker-controlled, enabling
  phishing, OAuth token/code theft, and SSRF/filter-bypass pivots. Invoke when a param controls
  a `Location`/meta/JS redirect (`return`, `next`, `url`, `redirect`, `dest`). Focuses on
  bypassing naive host validators; high value as an OAuth/chain component.
family: 07-client-side
type: exploit
owasp: [A01:2021]
cwe: [CWE-601]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Open Redirect

## Invoke when
- A param drives a redirect (header/meta/JS) — `next`, `return`, `url`, `redirect`, `callback`.

## Methodology
1. Set the param to an external host; confirm the redirect leaves the origin.
2. If validated, bypass: `//evil.tld`, `https:evil.tld`, `/\evil.tld`, `https://app.com@evil.tld`,
   `https://app.com.evil.tld`, backslash/whitespace/encoding tricks, `?next=https://evil` path confusion.
3. Grade impact by consumer (OAuth `redirect_uri` >> marketing link).

## Starter payloads
- `//evil.tld`, `/\/evil.tld`, `https://app.com@evil.tld`, `%2f%2fevil.tld`, `https:/evil.tld`.

## False-positive filters
- Redirect to a same-origin relative path only = not open; a warning interstitial reduces phishing impact.

## Chains to
- `auth-oauth-oidc-abuse`, `ssrf-filter-bypass`, `web-cache-poisoning`.
