---
name: crypto-padding-oracle
description: >-
  Exploit a padding oracle (CWE-347/CWE-696): CBC-mode ciphertext whose padding-validity leaks
  via distinguishable responses/timing, enabling decryption and forgery without the key. Invoke
  when an encrypted token/cookie/param is decrypted server-side and error/behavior differs for
  valid vs invalid padding. Also covers deprecated fixed-IV/ECB pattern leakage.
family: 10-crypto-data
type: exploit
owasp: [A02:2021]
cwe: [CWE-347, CWE-696]
requires: [util-differential-oracle]
authorization: required
---

# Padding Oracle

## Invoke when
- A CBC-encrypted blob is submitted and the server reveals padding validity (distinct error/status/time).

## Methodology
1. Confirm the oracle: tamper the last byte; is "padding error" distinguishable from other errors?
2. Run the padding-oracle decryption per block (byte-by-byte) using the differential oracle.
3. For forgery (e.g., CBC-R), encrypt attacker-chosen plaintext to mint valid tokens.
4. ECB tell: identical plaintext blocks → identical ciphertext blocks (pattern leakage).

## Starter payloads
- Systematic last-byte manipulation across blocks (padbuster-style).

## False-positive filters
- Uniform error for all tampering = no oracle. Encrypt-then-MAC (auth-enc) defeats this — check for a MAC first.

## Tooling
- `padbuster`; custom oracle harness keyed on the differential.
