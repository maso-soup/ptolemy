---
name: crypto-weak-tls-config
description: >-
  Assess transport crypto (A02): deprecated protocols (SSLv3/TLS1.0/1.1), weak ciphers/export
  suites, missing PFS, weak DH params, expired/misissued/self-signed certs, missing HSTS, and
  mixed content. Invoke when a host serves TLS and transport hardening is in scope. Mostly
  observational (no exploitation), feeding the report and enabling downstream MITM assumptions.
family: 10-crypto-data
type: exploit
owasp: [A02:2021]
cwe: [CWE-326, CWE-327]
requires: []
authorization: required
---

# Weak TLS / Transport Config

## Invoke when
- A host serves HTTPS and transport-security posture is in scope.

## Methodology
1. Enumerate supported protocols/ciphers; flag SSLv3/TLS1.0-1.1, RC4/3DES/EXPORT/NULL, no-PFS.
2. Check cert: validity, chain, hostname match, key size, signature algo.
3. Headers: HSTS presence/max-age/preload; detect mixed content.
4. Report; note where weak transport enables realistic interception.

## Tooling
- `testssl.sh`, `sslscan`, `nmap --script ssl-enum-ciphers`.

## False-positive filters
- Legacy suites offered but not negotiated by modern clients = lower risk; distinguish "supported" vs "preferred".
