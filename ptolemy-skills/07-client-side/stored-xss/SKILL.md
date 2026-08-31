---
name: stored-xss
description: >-
  Exploit stored/persistent XSS (CWE-79): payload saved server-side and executed whenever any
  user views the affected view. Invoke when input is persisted (comments, profile, filenames,
  messages) and later rendered. Higher impact than reflected (no delivery needed); must locate
  the render sink, which may differ from the input form (admin panels, notifications).
family: 07-client-side
type: exploit
owasp: [A03:2021]
cwe: [CWE-79]
requires: [xss-context-triage]
authorization: required
---

# Stored XSS

## Invoke when
- Input persists and is rendered later to self or others.

## Methodology
1. Store a context-appropriate payload + unique marker.
2. Enumerate every view that renders the stored value (self view, other users, admin dashboards,
   exports, notifications) — the vulnerable sink may not be the input page.
3. Confirm execution at a render sink; assess who is affected (self/other/admin) for severity.
4. Prefer a benign proof; do not target real users' sessions.

## Starter payloads
- `<img src=x onerror=PROOF>`, `<svg onload=PROOF>`, context-matched break-outs from triage.

## False-positive filters
- Payload stored but HTML-encoded on render = safe; a payload that executes only in *your* view is still valid but note the audience.
