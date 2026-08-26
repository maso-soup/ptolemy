---
name: coupon-referral-abuse
description: >-
  Exploit promo/coupon/referral/loyalty logic (CWE-840): stack single-use coupons, reuse
  one-time codes, self-refer, farm signup bonuses, or redeem beyond limits. Invoke when discount
  codes, referral credit, loyalty points, or signup incentives exist. Overlaps race-conditions
  for concurrency-based reuse; this skill covers the logic/identity side.
family: 09-business-logic
type: exploit
owasp: [A04:2021]
cwe: [CWE-840, CWE-799]
requires: [scope-guard, bizlogic-flow-mapper, evidence-recorder]
authorization: required
---

# Coupon / Referral / Loyalty Abuse

## Invoke when
- The app grants value via codes, referrals, points, or first-time incentives.

## Methodology
1. Reuse a single-use coupon (re-apply, apply across sessions/accounts).
2. Stack incompatible discounts / apply after price is locked.
3. Self-referral or circular referral to farm credit; multi-account signup-bonus farming.
4. Redeem points beyond balance / negative redemption.
5. Confirm the granted value exceeds policy on test accounts.

## Starter payloads
- Re-POST `apply_coupon=SAVE50`; combine `SAVE50`+`FREESHIP`+`WELCOME`; refer your own new account.

## False-positive filters
- Server-enforced one-time/exclusive rules block this — confirm the extra value was actually granted.

## Chains to
- `race-conditions` (concurrent reuse), `chain-builder`.
