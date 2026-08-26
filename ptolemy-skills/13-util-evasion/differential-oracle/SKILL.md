---
name: util-differential-oracle
description: >-
  Shared response-differencing oracle for content-based blind techniques. Invoke to build a
  stable true/false discriminator between two responses by normalizing out noise (CSRF tokens,
  timestamps, ads, session echoes, ordering) and comparing structure/length/markers. Blind-boolean
  SQLi, NoSQL regex extraction, LDAP/XPath blind, and param-mining all depend on this. Not an attack.
family: 13-util-evasion
type: util
owasp: []
cwe: []
requires: []
authorization: required
---

# Differential Oracle (util)

## Invoke when
- A skill needs to reliably distinguish TRUE vs FALSE server states from responses.

## Methodology
1. Capture baseline responses for known-true and known-false inputs (multiple samples).
2. Learn the noise: strip/normalize volatile regions (tokens, dates, nonces, dynamic ads).
3. Derive a discriminator (normalized length/hash/marker presence) with a confidence margin.
4. Serve a boolean verdict to the caller; flag when the oracle is unstable (→ suggest timing/OOB).

## False-positive filters
- If true/false responses aren't separable after normalization, DO NOT fabricate a signal — report the oracle as unusable.

## Chains to
- `blind-boolean-sqli`, `nosql-injection`, `ldap-injection`, `xpath-injection`, `parameter-mining`.
