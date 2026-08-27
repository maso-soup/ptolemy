---
name: logging-monitoring-gaps
description: >-
  Assess security logging & monitoring failures (A09/CWE-778): whether high-signal events
  (auth failures, access-control denials, input-validation errors) are logged, alerted, and
  tamper-resistant, and whether the tester's own activity went undetected. Invoke near end of
  engagement to evaluate detection coverage. Assessment/inference — largely non-intrusive.
family: 11-config-components
type: exploit
owasp: [A09:2021]
cwe: [CWE-778, CWE-223]
requires: []
authorization: required
---

# Logging & Monitoring Gaps

## Invoke when
- Wrapping up: evaluate whether the target could detect/respond to the attacks performed.

## Methodology
1. From engagement records, note which noisy actions (brute force, IDOR sweeps, injection) drew
   any observable response (blocks, alerts, lockouts, rate limiting kicking in).
2. Check for log-injection risk (CRLF into logs) and absence of alerting signals.
3. Infer coverage gaps; recommend detections tied to the specific attacks that went unnoticed.

## False-positive filters
- Absence of a block ≠ absence of logging — frame findings as inferred coverage gaps, not proven blind spots, unless confirmed.
