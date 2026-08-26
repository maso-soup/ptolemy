---
name: header-injection
description: >-
  Exploit CRLF / HTTP header & response injection (CWE-93/113): inject `\r\n` into a value
  reflected in response headers to add headers, split responses, set cookies, or poison caches.
  Invoke when user input lands in a `Location`, `Set-Cookie`, custom header, or redirect. Feeds
  cache poisoning and open-redirect chains.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-93, CWE-113]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# CRLF / HTTP Header Injection

## Invoke when
- Input is reflected into a response header (redirect target, cookie, language, custom header).

## Methodology
1. Inject encoded CRLF and a marker header; check if it appears as a real header.
2. Escalate: inject `Set-Cookie`, split the response body, or add cache-control.
3. Try single `\n` and various encodings (`%0d%0a`, `%0a`, `%E5%98%8A`) — parsers differ.

## Starter payloads
- `%0d%0aX-Injected: 1`, `%0d%0aSet-Cookie: sess=attacker`, `%0d%0a%0d%0a<html>...` (split).

## False-positive filters
- Modern servers strip CR/LF in header values — a reflected literal `%0d%0a` is not a hit; confirm a real new header.

## Chains to
- `web-cache-poisoning`, `open-redirect`, `xss-context-triage` (if body-splitting yields HTML).
