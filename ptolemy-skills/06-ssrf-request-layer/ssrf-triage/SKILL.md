---
name: ssrf-triage
description: >-
  Entry point for Server-Side Request Forgery (A10). Invoke when a param takes a URL, host,
  or is used to fetch/import/render remote content (webhook, image proxy, PDF/screenshot
  generator, URL preview, import-from-URL, SSO metadata). Determines whether the server makes
  the request and whether responses are reflected, routing to basic/blind/metadata/bypass.
family: 06-ssrf-request-layer
type: triage
owasp: [A10:2021, API7:2023]
cwe: [CWE-918]
requires: [scope-guard, util-oast-oob]
authorization: required
---

# SSRF Triage

## Invoke when
- A param is a URL/host, or a feature fetches remote content on the server's behalf.

## Methodology
1. Point the param at a unique collaborator; confirm a server-side callback (not the browser's).
2. Determine reflection: is the fetched response body returned to you (in-band) or not (blind)?
3. Determine reachability: can the server hit internal IPs / cloud metadata?
4. Route: reflected+internal→`ssrf-basic`, cloud→`ssrf-cloud-metadata`, no reflection→`ssrf-blind`,
   filtered→`ssrf-filter-bypass`.

## False-positive filters
- Client-side fetch (CORS/browser) is not SSRF — confirm the request originates from the server IP.

## Chains to
- `ssrf-basic`, `ssrf-cloud-metadata`, `ssrf-blind`, `ssrf-filter-bypass`.
