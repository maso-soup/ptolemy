---
name: auth-session-fixation-hijack
description: >-
  Test session management flaws: session fixation (session id not rotated on privilege
  change/login), missing HttpOnly/Secure/SameSite, session not invalidated on logout/
  password-change, and long-lived/replayable tokens. Invoke when session state is carried in
  a cookie/token and you can observe the pre/post-auth identifier.
family: 03-auth-session
type: exploit
owasp: [A07:2021]
cwe: [CWE-384, CWE-613]
requires: []
authorization: required
---

# Session Fixation & Hijack Hygiene

## Invoke when
- A session cookie/token exists and login/logout/privilege-change flows are testable.

## Methodology
1. Capture pre-auth session id → authenticate → check the id rotates. No rotation = fixation.
2. Inspect cookie flags: HttpOnly, Secure, SameSite, Domain scope, Max-Age.
3. Logout/password-change → confirm old token is server-side invalidated (replay it).
4. Concurrent sessions & absolute timeout behavior.

## False-positive filters
- Token *string* changes client-side but server still honors the old one → still invalidation flaw.

## Evidence to capture
- Pre/post-auth identifiers; replay of a "logged-out" token succeeding.
