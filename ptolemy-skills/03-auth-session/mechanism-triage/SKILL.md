---
name: auth-mechanism-triage
description: >-
  Entry point for authentication & session testing (A07 / API2). Invoke when a login, token,
  SSO, MFA, password-reset, or session mechanism is in scope, to identify the auth model
  (form/JWT/OAuth/OIDC/SAML/session-cookie) and route to the right exploit skill. Fingerprints
  token format, session lifecycle, and reset flow before any active attack.
family: 03-auth-session
type: triage
owasp: [A07:2021, API2:2023]
cwe: [CWE-287]
requires: [scope-guard]
authorization: required
---

# Auth Mechanism Triage

## Invoke when
- Any authentication, session, SSO, MFA, or credential-reset surface is present.

## Methodology
1. Classify token: opaque cookie vs JWT vs SAML assertion vs OAuth code/token.
2. Map lifecycle: login → session issuance → refresh → logout → reset.
3. Note protections: rate limiting, lockout, MFA, CSRF token, PKCE.
4. Route: JWT→`auth-jwt-attacks`, OAuth/OIDC→`auth-oauth-oidc-abuse`, SAML→`auth-saml-attacks`,
   reset flow→`auth-password-reset-abuse`, MFA→`auth-mfa-bypass`, weak creds→`auth-credential-attacks`.

## False-positive filters
- A JWT-looking string may be opaque/random — decode before assuming structure.

## Chains to
- the specific `auth-*` exploit skills; `auth-session-token-analysis` for entropy.
