---
name: xpath-injection
description: >-
  Exploit XPath/XQuery injection (CWE-643): tamper an XPath query over an XML datastore to
  bypass auth or extract nodes via boolean/blind techniques. Invoke when input feeds an XPath
  expression (XML-backed login or lookup). Structurally similar to SQLi-blind but over XML.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-643]
requires: [util-differential-oracle]
authorization: required
---

# XPath Injection

## Invoke when
- A param is embedded in an XPath/XQuery over XML data.

## Methodology
1. Break the expression (`'`, `"`, `or 1=1`) and observe result-set change.
2. Auth bypass via always-true predicate.
3. Blind extraction: `substring(name(/*[1]),i,1)` boolean probing (differential oracle);
   enumerate structure with `count()` and `string-length()`.

## Starter payloads
- `' or '1'='1`, `x' or 1=1 or 'x'='y`, `']|//user/*|//*['`.

## False-positive filters
- App-level filtering may strip quotes — test unquoted numeric contexts too.
