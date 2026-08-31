---
name: util-oast-oob
description: >-
  Shared out-of-band interaction service (OAST) manager. Invoke from any blind skill to mint a
  unique collaborator subdomain/URL, then correlate incoming DNS/HTTP/SMTP callbacks back to the
  exact probe that caused them. This is the confirmation oracle for blind SQLi/command/SSRF/XXE/
  deserialization/blind-XSS. A dependency, not an attack itself.
family: 13-util-evasion
type: util
owasp: []
cwe: []
requires: []
authorization: required
---

# OAST / OOB Interaction (util)

## Invoke when
- A blind technique needs external confirmation (no in-band signal).

## Methodology
1. Generate a unique correlation subdomain/URL per probe and track the token for correlation.
2. Embed it in the caller's payload (DNS resolve, HTTP fetch, SMTP send).
3. Poll for interactions; match callback → probe via the unique token.
4. Extract any exfiltrated data carried in the callback (subdomain label / path / body).

## Starter payloads
- `<token>.collab.tld` for DNS; `http://<token>.collab.tld/<b64data>` for HTTP exfil.

## False-positive filters
- Shared/guessable subdomains cause cross-talk — always per-probe unique tokens.
