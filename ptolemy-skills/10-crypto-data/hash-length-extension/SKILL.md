---
name: crypto-hash-length-extension
description: >-
  Exploit hash length-extension (CWE-345/CWE-347): when a signature is `H(secret || message)`
  with a Merkle–Damgard hash (MD5/SHA-1/SHA-256), append data and forge a valid MAC without the
  secret. Invoke when an integrity/signature parameter appears to be a raw prepend-secret hash
  over concatenated data (common in home-grown signed URLs/API params).
family: 10-crypto-data
type: exploit
owasp: [A02:2021]
cwe: [CWE-345, CWE-347]
requires: []
authorization: required
---

# Hash Length-Extension

## Invoke when
- A request carries a hash "signature" over concatenated fields and the scheme looks like `H(secret||data)`.

## Methodology
1. Identify the hash (length/charset) and the signed data layout.
2. Guess/brute the secret length; use length-extension to append attacker data and compute the new valid hash.
3. Submit the extended message+hash; confirm it's accepted (e.g., elevated param honored).

## Starter payloads
- `hash_extender -d "<known>" -s "<sig>" -a "&admin=1" -f sha256 --secret-min N --secret-max M`.

## False-positive filters
- HMAC (`H(secret, H(secret, msg))`) is NOT vulnerable — confirm it's a plain prepend-secret hash, not HMAC.
