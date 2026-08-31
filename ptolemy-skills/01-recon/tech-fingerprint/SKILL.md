---
name: tech-fingerprint
description: >-
  Identify the server, framework, language, CMS, WAF/CDN, and versions behind a host from
  headers, cookies, error pages, asset hashes, and behavior. Invoke early per host — its
  output selects which payload dialects and CVE lookups downstream skills use. Detecting a
  WAF here changes evasion strategy for every later injection skill.
family: 01-recon
type: recon
owasp: [A06:2021]
cwe: [CWE-200]
requires: []
authorization: required
---

# Tech Fingerprint

## Invoke when
- A live host is confirmed, before running class triage — dialect selection depends on it.

## Methodology
1. Parse Server/X-Powered-By/Set-Cookie name patterns (JSESSIONID, laravel_session, etc.).
2. Trigger a benign error → framework stack-trace/format signature.
3. Hash static assets / favicon → known-app match.
4. Probe WAF/CDN fingerprints (block-page signatures, header ordering).

## False-positive filters
- Reverse proxies/CDNs mask origin tech — note the layer each signal came from.

## Evidence to capture
- Component + version confidence; WAF vendor (feeds `util-waf-bypass`).
