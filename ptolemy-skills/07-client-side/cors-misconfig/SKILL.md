---
name: cors-misconfig
description: >-
  Exploit CORS misconfiguration (CWE-942): overly permissive Access-Control-Allow-Origin that
  reflects arbitrary origins or trusts `null`/subdomains WITH credentials, letting an attacker
  site read authenticated responses. Invoke when an endpoint returns sensitive data and its ACAO
  handling is loose. Confirms credentialed cross-origin read, not just a permissive header.
family: 07-client-side
type: exploit
owasp: [A05:2021]
cwe: [CWE-942]
requires: []
authorization: required
---

# CORS Misconfiguration

## Invoke when
- A sensitive endpoint sets ACAO dynamically or permissively.

## Methodology
1. Send varied `Origin` values; observe `Access-Control-Allow-Origin` + `-Allow-Credentials`.
2. Dangerous patterns: ACAO reflects arbitrary Origin + ACAC:true; trusts `null`; weak
   subdomain/regex (`app.com.evil.com`, `evilapp.com`).
3. Confirm exploitability: cross-origin credentialed `fetch` actually reads the response body.
4. Grade by data sensitivity read.

## Starter payloads
- `Origin: https://evil.tld` (check reflection+credentials), `Origin: null` (sandbox/data-URL), `Origin: https://app.com.evil.tld`.

## False-positive filters
- ACAO reflecting an origin WITHOUT `Allow-Credentials:true` can't read authed data via cookies — lower/again impact.
- `*` with credentials is rejected by browsers — not exploitable for credentialed reads.
