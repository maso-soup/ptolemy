---
name: ldap-injection
description: >-
  Exploit LDAP injection (CWE-90): tamper filter syntax to bypass authentication or enumerate
  directory data via boolean/blind extraction. Invoke when input feeds an LDAP search filter
  (login against AD/OpenLDAP, user lookup). Wildcards and always-true filters are the first probes.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-90]
requires: [util-differential-oracle]
authorization: required
---

# LDAP Injection

## Invoke when
- A param is used in an LDAP filter (directory login/search), often signaled by AD/LDAP stacks.

## Methodology
1. Break filter syntax with `)` `(` `*` `|` `&`; watch for filter errors or auth changes.
2. Auth bypass: inject an always-true clause / wildcard user.
3. Blind extraction: attribute char-by-char with boolean filters (differential oracle).

## Starter payloads
- `*`, `*)(uid=*))(|(uid=*`, `admin)(|(password=*)`, `*)(objectClass=*`.

## False-positive filters
- Input rejected by schema validation ≠ injection; confirm filter-logic change (extra results/bypass).
