---
name: clickjacking
description: >-
  Exploit UI redressing / clickjacking (CWE-1021): a sensitive action can be framed and overlaid
  so a victim's click triggers it, because X-Frame-Options/CSP frame-ancestors are missing.
  Invoke on state-changing UI actions when framing isn't blocked. Produces a framing PoC and
  identifies the specific unprotected action (esp. those without a confirmation step).
family: 07-client-side
type: exploit
owasp: [A05:2021]
cwe: [CWE-1021]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Clickjacking

## Invoke when
- A sensitive action page can be iframed (no XFO deny/sameorigin, no CSP frame-ancestors).

## Methodology
1. Check framing headers on the target action page.
2. If framable, build a PoC overlaying the target iframe under decoy UI (opacity/pointer tricks).
3. Confirm the click reaches the real control; prefer single-click, no-confirmation actions.
4. Consider drag-and-drop / multi-step variants where relevant.

## Starter payloads
- Iframe of the action page with `opacity:0.0001`, positioned under a "Click to win" button.

## False-positive filters
- `X-Frame-Options: DENY/SAMEORIGIN` or `frame-ancestors 'none'/'self'` = not framable; a framable but
  purely informational page is low impact.

## Chains to
- `csrf` (framing where token blocks classic CSRF), `chain-builder`.
