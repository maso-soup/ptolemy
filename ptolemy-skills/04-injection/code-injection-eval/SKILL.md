---
name: code-injection-eval
description: >-
  Exploit direct server-side code injection into a language interpreter (CWE-94/95): input
  reaching eval/exec/Function/`system`-of-language constructs (PHP eval, Python eval/exec,
  Node Function/vm, Ruby eval). Invoke when a param appears to be evaluated as code rather than
  a template or shell. Distinct from SSTI (template engine) and command injection (shell).
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-94, CWE-95]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Code Injection (eval/exec)

## Invoke when
- Input flows into a language `eval`/`exec`/`Function`/`vm` sink (not a template, not a shell).

## Methodology
1. Confirm evaluation with a language-native expression producing a distinct value/side effect.
2. Escalate to command exec via the language's runtime (kept to `id`/marker).
3. Handle context (string concat vs statement) and any sandbox (Node `vm`) escape.

## Starter payloads
- PHP: `phpinfo()` / `system('id')` where value hits `eval`.
- Python: `__import__('os').popen('id').read()`.
- Node: `require('child_process').execSync('id')`; vm-escape via `this.constructor.constructor('return process')()`.
- Ruby: `` `id` `` / `system('id')`.

## False-positive filters
- Reflected literal code ≠ execution. Require the computed value/side effect.

## Chains to
- `node-prototype-pollution` (gadget to eval), `chain-builder`.
