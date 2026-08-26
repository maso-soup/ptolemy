---
name: csti
description: >-
  Exploit Client-Side Template Injection (CWE-1336 client variant): user input evaluated by a
  client-side template/expression engine (AngularJS `{{}}`, Vue, older sandboxes) leading to
  sandbox escape and XSS/JS execution. Invoke when `{{7*7}}`→49 happens in the DOM (not server)
  or an Angular/Vue app reflects input into template-parsed regions. Distinct from server SSTI.
family: 07-client-side
type: exploit
owasp: [A03:2021]
cwe: [CWE-1336, CWE-79]
requires: [scope-guard, xss-context-triage, evidence-recorder]
authorization: required
---

# Client-Side Template Injection

## Invoke when
- Client framework evaluates reflected input as a template (`{{}}` computes in the browser DOM).

## Methodology
1. Confirm client-side evaluation (`{{7*7}}`→49 rendered by the framework, not the server).
2. Identify framework/version (AngularJS 1.x sandbox era vs sandbox-less modern).
3. Use the version's sandbox-escape gadget to reach `window`/JS execution.

## Starter payloads
- AngularJS ≥1.6 (no sandbox): `{{constructor.constructor('PROOF')()}}`
- Older AngularJS sandbox escapes (version-specific `$eval`/`orderBy` gadgets).
- Vue: `{{_c.constructor('PROOF')()}}` (context-dependent).

## False-positive filters
- Literal `{{7*7}}` in output (not computed) = not CSTI; may be reflected XSS instead.

## Chains to
- `dom-xss`, `content-security-policy-bypass`.
