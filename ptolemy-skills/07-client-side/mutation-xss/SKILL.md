---
name: mutation-xss
description: >-
  Exploit mutation XSS (mXSS) and HTML-sanitizer bypasses (CWE-79/CWE-80): payloads that are
  inert as parsed but become executable after the browser's HTML re-serialization/normalization
  mutates them, defeating DOMPurify/sanitizers. Invoke when a sanitizer is present and reflected/
  stored XSS payloads are being stripped — this is the next escalation.
family: 07-client-side
type: exploit
owasp: [A03:2021]
cwe: [CWE-79, CWE-80]
requires: [scope-guard, xss-context-triage, evidence-recorder]
authorization: required
---

# Mutation XSS / Sanitizer Bypass

## Invoke when
- An HTML sanitizer (DOMPurify, server-side allowlist) is neutralizing straightforward payloads.

## Methodology
1. Identify the sanitizer + version (behavior/fingerprint) → known-bypass lookup.
2. Craft namespace/parsing-confusion payloads (SVG/MathML foreign content, `<template>`, noscript
   context switches) that mutate on re-serialization into executable markup.
3. Test the exact insertion context (innerHTML re-parse) where mutation occurs.

## Starter payloads
- `<svg><style><img src=x onerror=PROOF>` (foreign-content confusion),
  `<math><mtext><table><mglyph><style><img src=x onerror=PROOF>` (mXSS classic),
  `<noscript><p title="</noscript><img src=x onerror=PROOF>">`.

## False-positive filters
- Up-to-date DOMPurify with default config blocks most public mXSS — confirm the specific version/config gap.

## Chains to
- `stored-xss`/`reflected-xss` delivery once a working bypass is found.
