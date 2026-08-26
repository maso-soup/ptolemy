---
name: auth-password-reset-abuse
description: >-
  Attack the forgotten-password flow: predictable/leaked reset tokens, host-header poisoning
  to hijack the reset link, token not bound to user, reset without old password, and reset
  response leaking the token. Invoke when a password-reset / magic-link flow is present — a
  common full-account-takeover path.
family: 03-auth-session
type: exploit
owasp: [A07:2021]
cwe: [CWE-640, CWE-620]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Password Reset Abuse

## Invoke when
- A reset-by-email/magic-link or "change password" flow exists.

## Methodology
1. Request reset for a test account; inspect token entropy/format and TTL.
2. Host-header poisoning: set `Host`/`X-Forwarded-Host` to an attacker domain → does the
   emitted link point there? (token exfil on victim click).
3. Token binding: use account-A's token to reset account-B.
4. Missing old-password check on authenticated "change password".
5. Token/PII leakage in the reset API response or redirect.

## Starter payloads
- `Host: attacker.tld`, `X-Forwarded-Host: attacker.tld`; reuse token across users; enumerate
  sequential/timestamp-seeded tokens.

## False-positive filters
- Poisoned host in link but token still single-use & bound → lower severity; verify takeover.

## Chains to
- `host-header-attacks`, `auth-session-token-analysis`, `chain-builder`.
