---
name: reflected-xss
description: >-
  Exploit reflected XSS (CWE-79): input echoed in the immediate response executes in the
  victim's browser. Invoke when a param reflects into HTML/JS in the same response and the
  output context allows script. Builds a context-correct break-out and a delivery URL; confirms
  execution, not mere reflection.
family: 07-client-side
type: exploit
owasp: [A03:2021]
cwe: [CWE-79]
requires: [xss-context-triage]
authorization: required
---

# Reflected XSS

## Invoke when
- A param reflects into the same response in a script-capable context.

## Methodology
1. Take the context + surviving-chars profile from triage.
2. Build the minimal break-out (close tag/attribute/quote) + payload.
3. Confirm execution with a benign non-alert proof (e.g., `fetch` to collaborator / `console` marker
   observable via DOM), then craft a shareable PoC URL.
4. Note any input transforms (URL-decoding count, case-folding) to survive them.

## Starter payloads (by context)
- HTML body: `"><svg onload=PROOF>`
- Quoted attr: `" autofocus onfocus=PROOF x="`
- JS string: `';PROOF;//` or `\';PROOF;//`
- URL/href: `javascript:PROOF`

## False-positive filters
- Reflection inside a textarea/comment/`<script>` that isn't closed = no execution; verify DOM actually runs it.
