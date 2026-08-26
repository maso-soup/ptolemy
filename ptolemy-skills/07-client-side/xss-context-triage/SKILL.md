---
name: xss-context-triage
description: >-
  Entry point for cross-site scripting. Invoke when input is reflected into a response or DOM,
  to classify the OUTPUT CONTEXT (HTML body, attribute, JS string, URL, CSS, or JSON) and
  reflection type (reflected/stored/DOM), which dictates the payload and encoding. Routes to
  reflected/stored/dom/blind/mutation-xss with the exact break-out sequence for that context.
family: 07-client-side
type: triage
owasp: [A03:2021]
cwe: [CWE-79]
requires: [scope-guard]
authorization: required
---

# XSS Context Triage

## Invoke when
- A parameter's value appears in HTML/JS/attribute/URL/CSS output or a DOM sink.

## Methodology
1. Inject a unique alphanumeric marker; locate every reflection and its context.
2. Per reflection, probe which metacharacters survive (`< > " ' \` / =`) — this defines the break-out.
3. Classify: HTML-body / attribute (quoted vs unquoted) / JS-string / event-handler / URL / CSS / JSON.
4. Determine reflected vs stored vs DOM (source→sink in JS).
5. Route with the context-specific payload template.

## False-positive filters
- Marker reflected but all of `<"'` are entity-encoded = likely safe in that context; check other reflections.

## Chains to
- `reflected-xss`, `stored-xss`, `dom-xss`, `blind-xss`, `mutation-xss`, `csti`, `content-security-policy-bypass`.
