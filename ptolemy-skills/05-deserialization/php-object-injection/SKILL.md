---
name: php-object-injection
description: >-
  Exploit PHP object injection / insecure unserialize (CWE-502): craft serialized objects that
  trigger POP (property-oriented programming) gadget chains via magic methods (__wakeup,
  __destruct, __toString). Invoke when `unserialize()` receives client input (cookies, params)
  and gadget classes exist in the codebase/frameworks (Laravel, Monolog, Guzzle).
family: 05-deserialization
type: exploit
owasp: [A08:2021]
cwe: [CWE-502]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# PHP Object Injection

## Invoke when
- Client-controlled data reaches `unserialize()` and usable magic-method gadgets exist.

## Methodology
1. Locate `unserialize()` sinks and available classes with dangerous magic methods.
2. Build a POP chain (often via PHPGGC for known frameworks).
3. Craft the serialized `O:len:"Class":n:{...}` object; adjust property counts/visibility (`\0`).
4. Confirm side effect (file write, OOB, RCE) with a marker.

## Starter payloads
- `phpggc Laravel/RCE1 system id` → base64 into the cookie/param.
- Manual: `O:4:"Evil":1:{s:3:"cmd";s:2:"id";}` (illustrative).

## False-positive filters
- No reachable gadget = injection without impact; note property-visibility null bytes when hand-crafting.

## Tooling
- `phpggc` for framework gadget chains.

## Chains to
- `file-upload-abuse` (phar://), `chain-builder`.
