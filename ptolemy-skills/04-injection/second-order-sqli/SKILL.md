---
name: second-order-sqli
description: >-
  Exploit stored/second-order SQL injection: the payload is safely stored on one request and
  executed later in a different, unparameterized query (CWE-89). Invoke when input is persisted
  (profile fields, usernames, notes) and re-used server-side elsewhere. Detection requires
  tracking the delayed sink, not the storing endpoint.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-89]
requires: [util-oast-oob]
authorization: required
---

# Second-Order SQLi

## Invoke when
- User input is stored and later consumed by another feature (search, admin view, batch job).

## Methodology
1. Seed a stored field with a payload + a unique OOB/marker (`'||(exfil)||'`).
2. Exercise features that likely re-query the stored value (profile render, reports, admin).
3. Watch for the OOB callback/error/timing at the delayed sink to locate execution.
4. Once located, apply the appropriate oracle (error/blind/time/OOB) at that sink.

## Starter payloads
- Store username: `x'||(SELECT ...)||'` or `x'-- -`; combine with `util-oast-oob` marker to catch the delayed fire.

## False-positive filters
- Payload may render harmlessly in many views; only the view that *re-queries* it matters.
