---
name: rate-limit-bypass
description: >-
  Bypass rate limiting / anti-automation controls (CWE-799/CWE-307): defeat per-IP/per-account
  throttles via IP rotation headers (X-Forwarded-For), case/path/param variation, distributed
  values, or resetting counters, to enable brute force, enumeration, or resource abuse. Invoke
  when a control throttles requests and other skills need higher throughput within scope.
family: 09-business-logic
type: exploit
owasp: [A04:2021, API4:2023]
cwe: [CWE-799, CWE-307]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Rate-Limit Bypass

## Invoke when
- A throttle/lockout blocks a legitimate test (brute, enum) and bypass is in scope + rate-capped.

## Methodology
1. Identify the limiter's key (IP, header, account, token, path).
2. Rotate the key: `X-Forwarded-For`/`X-Real-IP`/`X-Client-IP` spoofing, header casing/whitespace,
   path/param jitter, alternate endpoints performing the same action.
3. Detect counter-reset behaviors (per-minute windows, logout/login reset).
4. Confirm sustained throughput above the intended limit — still honor the engagement's absolute cap.

## Starter payloads
- `X-Forwarded-For: 1.2.3.<n>`, `X-Originating-IP`, dup/case headers, `/api/login` vs `/api//login`.

## False-positive filters
- A limiter keyed server-side on authenticated identity ignores IP-header spoofing — verify throughput actually rises.

## Chains to
- `auth-credential-attacks`, `idor-bola` (enumeration), any brute-dependent skill.
