---
name: race-conditions
description: >-
  Exploit race conditions / TOCTOU (CWE-362/CWE-367): concurrent requests defeat a check-then-act
  gap to double-spend, over-withdraw, redeem a one-time code N times, or bypass limits. Invoke on
  value/limit-bearing actions (redeem, withdraw, apply-coupon, vote, transfer) where a check
  precedes an act. Uses single-packet / burst concurrency; requires a measurable duplicated effect.
family: 09-business-logic
type: exploit
owasp: [A04:2021]
cwe: [CWE-362, CWE-367]
requires: [bizlogic-flow-mapper]
authorization: required
---

# Race Conditions / TOCTOU

## Invoke when
- An action checks a limit/balance/uniqueness then acts, and requests can be parallelized.

## Methodology
1. Identify the check-then-act target and the observable effect of a double-execution.
2. Fire N concurrent identical requests aligned to arrive together (HTTP/2 single-packet, or
   synchronized burst) to hit the pre-commit window.
3. Confirm an over-count effect (2+ redemptions of a one-time item, negative balance, duplicate resource).
4. Keep test values small; use test accounts; never exploit real financial balances beyond proof.

## Starter payloads
- 20–50 parallel `POST /redeem` / `POST /withdraw` on a single-use token or exact-balance amount.

## False-positive filters
- Server-side locking/idempotency keys/unique constraints defeat this — a single success ≠ race; require duplicated effect.

## Tooling
- HTTP/2 single-packet attack (Burp Turbo Intruder), or a concurrency script with a barrier.
