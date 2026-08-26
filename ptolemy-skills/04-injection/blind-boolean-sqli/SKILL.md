---
name: blind-boolean-sqli
description: >-
  Exploit blind SQL injection via a boolean (content) oracle: no data or error is returned,
  but TRUE vs FALSE conditions produce distinguishable responses (CWE-89). Invoke when
  injection changes the response deterministically for true/false predicates but shows no
  output/error. Extracts data bit-by-bit using the differential oracle.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-89]
requires: [scope-guard, util-differential-oracle, oracle-manager, evidence-recorder]
authorization: required
---

# Blind Boolean-Based SQLi

## Invoke when
- No error/output, but `AND 1=1` vs `AND 1=2` yield reliably different responses.

## Prerequisites & oracle
- A stable boolean oracle from `util-differential-oracle` (length/hash/marker distinguishing true/false).

## Methodology
1. Establish the true/false fingerprints; store in `oracle-manager`.
2. Confirm control with `' AND 1=1-- -` (baseline-true) vs `' AND 1=2-- -` (baseline-false).
3. Extract via predicates: `SUBSTRING((SELECT ...),i,1) > c` binary-search per character.
4. Batch-enumerate schema/rows; bound to PoC + one sensitive value.

## Starter payloads
- `' AND (SELECT SUBSTRING(version(),1,1))='8'-- -`
- `' AND ASCII(SUBSTRING((SELECT database()),1,1))>77-- -` (binary search)

## False-positive filters
- Non-injection response variance (ads, timestamps, CSRF tokens) poisons the oracle — the
  differential oracle must normalize these out first.

## Tooling
- `sqlmap --technique=B`; custom binary-search script keyed on the stored fingerprint.

## Chains to
- `time-based-blind-sqli` (if boolean oracle is unstable), `oob-sqli` (faster exfil).
