---
name: auth-credential-attacks
description: >-
  Rate-limit-aware credential guessing against authorized test accounts only: password
  spraying, credential stuffing with provided lists, and default-credential checks. Invoke
  when a login lacks lockout/MFA and you have authorization to test account resilience. NOT
  for mass targeting of real users — respects scope's allowed identities and rate ceiling.
family: 03-auth-session
type: exploit
owasp: [A07:2021]
cwe: [CWE-307, CWE-521]
requires: []
authorization: required
---

# Credential Attacks (authorized)

## Invoke when
- Login has weak/absent lockout and testing credential resilience is in scope.

## Do not invoke when
- Targets are real end-user accounts not covered by scope → HALT, this is out of bounds.

## Methodology
1. Confirm allowed identities/wordlists per scope; set a conservative rate under lockout threshold.
2. Spray one password across allowed accounts (avoids per-account lockout) OR stuff provided pairs.
3. Detect success oracle (redirect, Set-Cookie, differing length/timing).
4. Stop at first proof; do not enumerate beyond what proves the weakness.

## False-positive filters
- Generic "invalid" for both bad-user and bad-pass = no user enumeration; differing responses = enumeration finding too.

## Evidence to capture
- The missing control (no lockout/MFA/rate limit) + one demonstrated success under authorization.
