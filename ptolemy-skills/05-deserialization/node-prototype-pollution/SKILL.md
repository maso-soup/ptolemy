---
name: node-prototype-pollution
description: >-
  Exploit prototype pollution (CWE-1321): inject `__proto__`/`constructor.prototype` keys via
  merge/clone/query-parse to taint Object.prototype, then leverage a gadget for DoS, property
  injection, XSS, or RCE (server-side gadget → command exec). Invoke when JSON/query input is
  deep-merged or when client-side merges taint globals. Covers server and client variants.
family: 05-deserialization
type: exploit
owasp: [A08:2021, A03:2021]
cwe: [CWE-1321]
requires: []
authorization: required
---

# Prototype Pollution

## Invoke when
- Input is deep-merged/cloned (`lodash.merge`, `Object.assign` loops, `qs`), or client JS merges user data.

## Methodology
1. Pollution probe: send `__proto__[polluted]=yes` (query) or `{"__proto__":{"polluted":"yes"}}` (JSON);
   check whether an unrelated object now exposes `polluted`.
2. Server-side: find a gadget (template options, child_process args, config flags) → escalate to RCE.
3. Client-side: pollute a property a sink reads (`innerHTML`, script src) → DOM XSS.
4. Use `constructor.prototype` variant if `__proto__` is filtered.

## Starter payloads
- `?__proto__[x]=1`, `{"constructor":{"prototype":{"isAdmin":true}}}`,
  gadget: `{"__proto__":{"shell":"/proc/self/exe","argv0":"..."}}` (framework-specific).

## False-positive filters
- Some libs null-prototype or freeze Object.prototype — pollution probe must show cross-object leakage.
