---
name: deserial-triage
description: >-
  Entry point for insecure deserialization (A08). Invoke when you spot serialized blobs in
  cookies/params/bodies/headers — base64 Java (`rO0`/`aced`), PHP `O:` strings, .NET
  `AAEAAAD`/BinaryFormatter, Python pickle, Ruby Marshal, Node serialized objects, or
  ViewState. Identifies the format+language and routes to the matching gadget-chain skill.
family: 05-deserialization
type: triage
owasp: [A08:2021]
cwe: [CWE-502]
requires: []
authorization: required
---

# Deserialization Triage

## Invoke when
- Opaque structured blobs appear in transported state (cookie, hidden field, param, header).

## Methodology
1. Decode candidate (base64/hex) and match magic bytes/prefixes:
   - Java: `rO0AB`(b64) / `aced0005`(hex); PHP: `O:8:"...":` / `a:`; .NET: `AAEAAAD/////`;
     Python pickle: `\x80\x04`/`(dp0`; Ruby Marshal: `\x04\b`; Node node-serialize: `_$$ND_FUNC$$_`.
2. Determine if the blob is deserialized server-side with attacker influence.
3. Route to `java-deserialization`, `dotnet-deserialization`, `php-object-injection`,
   `python-pickle-exploit`, or `node-prototype-pollution`.

## False-positive filters
- A signed/encrypted blob (HMAC/MAC prefix) may resist tampering — check for integrity protection first.

## Chains to
- the language-specific deserialization exploit skill.
