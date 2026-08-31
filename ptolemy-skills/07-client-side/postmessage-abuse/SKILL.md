---
name: postmessage-abuse
description: >-
  Exploit insecure window.postMessage handlers (CWE-345): a `message` listener that doesn't
  verify `event.origin` and passes data to a sink (innerHTML, eval, location, token storage),
  enabling cross-origin DOM XSS or data theft. Invoke when JS analysis finds `addEventListener
  ('message', ...)` without origin checks, or an app embeds/postMessages with other frames.
family: 07-client-side
type: exploit
owasp: [A03:2021]
cwe: [CWE-345, CWE-79]
requires: [js-analysis]
authorization: required
---

# postMessage Abuse

## Invoke when
- A `message` event handler lacks/loosely-checks `event.origin` and uses the payload in a sink.

## Methodology
1. From `js-analysis`, locate message handlers and trace `event.data` to its sink.
2. Host an attacker page that opens/frames the target and posts a crafted message.
3. For an XSS sink → deliver a DOM-XSS payload; for a data sink → exfiltrate tokens/PII the handler stores.
4. Test broken origin checks (`indexOf`/`startsWith`, `*` target origin on sender side).

## Starter payloads
- `target.postMessage('<img src=x onerror=PROOF>', '*')`; `postMessage(JSON.stringify({type:'auth',token:'x'}))` mimicry.

## False-positive filters
- Handler that strictly checks `event.origin === 'https://trusted'` is safe — confirm the check is missing/bypassable.
