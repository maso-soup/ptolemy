---
name: util-timing-oracle
description: >-
  Shared statistical timing oracle for time-based blind techniques. Invoke to calibrate a latency
  baseline (p50/p90 with jitter) and then decide, per probe, whether an induced delay is real vs
  noise using repeated trials and a control. Time-based SQLi, blind command injection, and
  timing-based user-enumeration depend on this to avoid false positives from network jitter. Not an attack.
family: 13-util-evasion
type: util
owasp: []
cwe: []
requires: []
authorization: required
---

# Timing Oracle (util)

## Invoke when
- A skill infers state from response time (conditional delays / timing side channels).

## Methodology
1. Sample baseline latency (N requests); compute p50/p90 and jitter spread.
2. Choose an injected delay comfortably above p90 + jitter (e.g., 5s).
3. Per probe: run the delayed test and a no-delay control, repeated; require consistent separation.
4. Serve a boolean verdict + confidence; keep concurrency low to avoid load-induced noise.

## False-positive filters
- A single slow response is never a positive — require reproducible delay-vs-control separation across trials.

## Chains to
- `time-based-blind-sqli`, `blind-command-injection`.
