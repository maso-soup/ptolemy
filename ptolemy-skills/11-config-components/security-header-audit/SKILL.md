---
name: config-security-header-audit
description: >-
  Audit security-relevant response headers and cookie flags (A05): missing/weak CSP, HSTS,
  X-Content-Type-Options, X-Frame-Options/frame-ancestors, Referrer-Policy, Permissions-Policy,
  and cookie HttpOnly/Secure/SameSite. Invoke per host as a fast baseline hygiene pass; findings
  feed clickjacking, XSS-impact, and session skills. Assessment, not exploitation.
family: 11-config-components
type: exploit
owasp: [A05:2021]
cwe: [CWE-693, CWE-1021]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Security Header & Cookie Audit

## Invoke when
- A host is reachable and you want a quick defensive-posture baseline.

## Methodology
1. Capture response headers on key pages (login, app, API).
2. Evaluate: CSP (presence/strength), HSTS (max-age/preload), XCTO nosniff, XFO/frame-ancestors,
   Referrer-Policy, Permissions-Policy, CORP/COOP/COEP.
3. Evaluate cookies: HttpOnly, Secure, SameSite, Domain/Path scope.
4. Map each gap to the concrete risk it enables (feeds other skills), avoid boilerplate.

## False-positive filters
- A missing header is only a finding if the corresponding attack is actually applicable — link to the real risk.

## Chains to
- `clickjacking`, `content-security-policy-bypass`, `auth-session-fixation-hijack`.
