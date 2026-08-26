---
name: dom-xss
description: >-
  Exploit DOM-based XSS (CWE-79): a client-side source (location.hash/search, postMessage,
  document.referrer, storage) flows to a dangerous sink (innerHTML, document.write, eval,
  setAttribute, jQuery `$()`) with no server round-trip. Invoke when JS analysis reveals a
  source→sink taint path. Detection is client-side taint tracing, not response inspection.
family: 07-client-side
type: exploit
owasp: [A03:2021]
cwe: [CWE-79]
requires: [scope-guard, js-analysis, evidence-recorder]
authorization: required
---

# DOM XSS

## Invoke when
- A client-side source reaches an HTML/JS sink without server sanitization.

## Methodology
1. From `js-analysis`, list sources (`location.*`, `document.referrer`, `postMessage`, `localStorage`)
   and sinks (`innerHTML`, `outerHTML`, `document.write`, `eval`, `Function`, `setAttribute`, `location`).
2. Trace a controllable source to a sink; craft input that reaches the sink executable.
3. Deliver via the source channel (URL fragment, referrer, postMessage) — often no server involvement.
4. Confirm execution in the DOM; note that `#fragment` payloads never hit the server (WAF-invisible).

## Starter payloads
- `#<img src=x onerror=PROOF>` into a hash→innerHTML sink; `?redir=javascript:PROOF` into a location sink.

## False-positive filters
- Frameworks (React/Angular) auto-escape most sinks — only `dangerouslySetInnerHTML`/`bypassSecurityTrust`/
  raw DOM APIs are real sinks. Confirm the specific sink.

## Chains to
- `postmessage-abuse`, `node-prototype-pollution` (client gadget), `content-security-policy-bypass`.
