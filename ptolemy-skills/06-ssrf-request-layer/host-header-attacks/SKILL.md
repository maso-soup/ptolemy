---
name: host-header-attacks
description: >-
  Exploit Host / X-Forwarded-Host header trust (CWE-644): the app uses the client-supplied host
  to build absolute URLs (password-reset links, redirects), cache keys, or routing/access
  decisions. Invoke when host-derived output/behavior is observable. Feeds reset-link hijack,
  cache poisoning, and routing bypass.
family: 06-ssrf-request-layer
type: exploit
owasp: [A05:2021]
cwe: [CWE-644]
requires: []
authorization: required
---

# Host Header Attacks

## Invoke when
- The app echoes/uses Host or X-Forwarded-Host in links, redirects, cache keys, or auth.

## Methodology
1. Tamper `Host`, `X-Forwarded-Host`, `X-Host`, add a second Host header, or use absolute-URI request line.
2. Observe where the value surfaces (reset email link, redirect Location, canonical tags, cache).
3. Route the concrete impact to the right skill (reset hijack / poisoning / routing bypass).

## Starter payloads
- `Host: attacker.tld`, `X-Forwarded-Host: attacker.tld`, dual Host headers, `GET https://internal/ HTTP/1.1`.

## False-positive filters
- App with a strict allowlist of hosts ignores tampering — confirm attacker host actually influences output.
