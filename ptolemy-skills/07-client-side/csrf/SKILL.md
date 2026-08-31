---
name: csrf
description: >-
  Exploit Cross-Site Request Forgery (CWE-352): force a victim's authenticated browser to
  submit a state-changing request because the endpoint relies only on ambient cookies. Invoke
  on state-changing endpoints lacking anti-CSRF tokens or with weak SameSite. Analyzes token
  presence/validation and generates a working PoC HTML.
family: 07-client-side
type: exploit
owasp: [A01:2021]
cwe: [CWE-352]
requires: []
authorization: required
---

# CSRF

## Invoke when
- A cookie-authenticated, state-changing endpoint (POST/PUT/DELETE, or GET-with-effect) exists.

## Methodology
1. Inspect defenses: anti-CSRF token (present? validated? bound to session?), SameSite cookie,
   custom-header requirement, Origin/Referer checks.
2. Break token validation: remove it, reuse another user's, empty value, change method.
3. Test SameSite: `Lax` still allows top-level GET navigations — find a GET-effect or method gap.
4. Generate a PoC (auto-submitting form / `fetch` with credentials) and confirm the state change.

## Starter payloads
- Auto-submit form to the endpoint with attacker values; for JSON endpoints test `text/plain`
  content-type trick or missing preflight.

## False-positive filters
- Token present AND validated AND session-bound = not vulnerable. `SameSite=Strict` blocks cross-site sends.
