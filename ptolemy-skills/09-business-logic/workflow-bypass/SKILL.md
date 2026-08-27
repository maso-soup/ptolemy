---
name: workflow-bypass
description: >-
  Exploit broken multi-step workflow enforcement (CWE-840/CWE-841): skip, reorder, or replay
  steps (pay-then-ship without paying, complete KYC-gated action without KYC, reach a
  confirmation without prerequisites) because server state transitions aren't enforced. Invoke
  when a flow assumes clients proceed in order or trusts a client-sent "step/status" value.
family: 09-business-logic
type: exploit
owasp: [A04:2021]
cwe: [CWE-840, CWE-841]
requires: [bizlogic-flow-mapper]
authorization: required
---

# Workflow / State-Machine Bypass

## Invoke when
- A flow has ordered/gated steps whose enforcement may live on the client.

## Methodology
1. From the flow model, attempt to reach step N directly without N-1 (jump to confirmation/fulfillment).
2. Replay a completed step, or resubmit with a client-controlled `status=paid/approved`.
3. Reorder steps; skip payment/verification gates; reuse a prior step's token/reference.
4. Confirm the privileged end-state was reached without satisfying prerequisites.

## Starter payloads
- Direct `POST /order/confirm` skipping `/pay`; tamper `{"status":"PAID"}`; replay approval token.

## False-positive filters
- Server that re-derives state from authoritative records ignores client step-jumping — confirm the end-state actually changed.
