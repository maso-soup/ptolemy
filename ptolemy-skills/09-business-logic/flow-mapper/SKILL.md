---
name: bizlogic-flow-mapper
description: >-
  Entry point for business-logic testing. Invoke on multi-step flows (checkout, signup, KYC,
  transfers, subscription, redemption) to model the intended state machine, identify the
  security-relevant invariants (price integrity, ownership, step order, one-time use), and route
  to the specific logic-abuse skill. Logic bugs have no signature — they need the model this builds.
family: 09-business-logic
type: triage
owasp: [A04:2021]
cwe: [CWE-840, CWE-841]
requires: [crawler-authenticated]
authorization: required
---

# Business-Logic Flow Mapper

## Invoke when
- A multi-step or value-bearing workflow exists (cart→pay, apply→approve, transfer, redeem).

## Methodology
1. Enumerate steps, states, transitions, and the client-vs-server authority for each.
2. Identify invariants: price = server truth? quantity ≥ 0? step order enforced? token one-time?
   ownership checked at each step?
3. For each invariant, propose the violation test and route it.
4. Note idempotency/concurrency assumptions (feeds race-condition testing).

## Chains to
- `race-conditions`, `workflow-bypass`, `price-quantity-tampering`, `coupon-referral-abuse`, `rate-limit-bypass`.
