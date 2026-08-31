---
name: injection-reflection-triage
description: >-
  Entry point for all injection (A03). Invoke per parameter to determine WHERE user input
  lands (SQL query, OS command, LDAP/XPath filter, template, HTML/JS, header, ORM) and WHICH
  oracle is available (error reflection, boolean diff, timing, OOB), then route to the precise
  exploit skill. This skill decides error-based vs blind vs OOB before any heavy payloads fly.
family: 04-injection
type: triage
owasp: [A03:2021]
cwe: [CWE-74, CWE-707]
requires: [util-differential-oracle]
authorization: required
---

# Injection Reflection Triage

## Invoke when
- A parameter is reachable and its downstream interpreter/context is unknown.

## Methodology
1. Send benign markers and safe metacharacters (`' " ` \ ; ) | { { ` <`) one at a time.
2. Classify landing context from the response: SQL error, command output, template
   evaluation (`{{7*7}}→49`), HTML/JS reflection, LDAP/XPath error, stack trace.
3. Determine the available oracle: error string? content diff? time delay? OOB needed?
4. Route: SQL→SQL sub-family (by oracle), shell→`os-command-injection`/`blind-command-injection`,
   template→`ssti`, `{{}}`+JS→`csti`, LDAP→`ldap-injection`, XPath→`xpath-injection`,
   HTML/JS→`xss-context-triage`, CRLF→`header-injection`.

## False-positive filters
- WAF error pages mimic app errors — confirm the error is from the interpreter, not the WAF.
- Reflected `49` from `7*7` could be coincidence — vary the arithmetic to confirm evaluation.

## Chains to
- the specific injection exploit skill for the detected sink — e.g. `error-based-sqli`, `blind-boolean-sqli`, `time-based-blind-sqli`, `os-command-injection`, `ldap-injection`, `xpath-injection`, `ssti`, `orm-injection`, `header-injection`.
