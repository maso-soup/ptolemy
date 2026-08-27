---
name: java-deserialization
description: >-
  Exploit insecure Java deserialization (CWE-502) to RCE via gadget chains. Invoke when a Java
  serialized object (`aced0005` / `rO0AB`) is accepted from the client and classpath gadgets
  (Commons-Collections, Spring, etc.) are plausible. Selects the gadget chain from library
  fingerprints; confirms blind via timing/OOB.
family: 05-deserialization
type: exploit
owasp: [A08:2021]
cwe: [CWE-502]
requires: [util-oast-oob]
authorization: required
---

# Java Deserialization

## Invoke when
- Client-supplied Java serialized data is deserialized server-side.

## Methodology
1. Fingerprint libraries on the classpath (error messages, dependencies, CVEs).
2. Generate a gadget-chain payload matching an available library.
3. Confirm blind execution via DNS/HTTP OOB (URLDNS chain) before attempting full RCE.
4. Escalate to command exec (`id`/marker) only after OOB confirms reachability.

## Starter payloads
- Detection: `ysoserial URLDNS 'http://collab.tld'` (no gadget needed, proves deserialization+egress).
- RCE: `ysoserial CommonsCollections5 'command'` (match to classpath), Spring/JRMP variants.

## False-positive filters
- Deserialization may occur without a usable gadget — URLDNS callback proves the sink even when RCE chains fail.

## Tooling
- `ysoserial`, `marshalsec`; gadget selection guided by `components-known-cve-match`.
