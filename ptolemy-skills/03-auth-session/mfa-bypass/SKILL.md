---
name: auth-mfa-bypass
description: >-
  Attack multi-factor enforcement: flow-skipping (jump past the OTP step), response
  tampering (success:false→true), brute-forcing weak OTP/backup codes without rate limit,
  re-using/replaying codes, and disabling MFA via unprotected settings. Invoke when a second
  factor stands between valid primary creds and full session.
family: 03-auth-session
type: exploit
owasp: [A07:2021]
cwe: [CWE-287, CWE-308]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# MFA Bypass

## Invoke when
- Primary auth succeeds but a second factor gates full access.

## Methodology
1. Flow-skip: after primary auth, request the post-MFA resource/endpoint directly.
2. Response tamper: flip `{"mfa":false}`/`success` in the verification response or param.
3. Code brute: if OTP has no rate limit/lockout, exhaust the (small) code space.
4. Replay/reuse: submit a used code again; test cross-user code acceptance.
5. Config bypass: disable MFA via account settings without re-challenge.

## Starter payloads
- Direct GET to `/dashboard` post-primary-auth; `otp=000000..999999` (only if unthrottled);
  intercept `/verify` → force `verified=true`.

## False-positive filters
- Reaching a page that then re-challenges server-side ≠ bypass. Confirm privileged action.

## Chains to
- `auth-session-token-analysis`, `chain-builder`.
