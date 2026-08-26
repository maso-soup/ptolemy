---
name: path-traversal-lfi
description: >-
  Exploit path traversal / local file inclusion for arbitrary file READ (CWE-22/CWE-98): escape
  a base directory with `../`, encoded variants, null bytes, and wrappers to read sensitive files.
  Invoke when a param controls a file path used for read/download/render. Covers OS-specific
  targets and encoding bypasses; escalation to RCE routes to file-inclusion-rce.
family: 08-file-path
type: exploit
owasp: [A01:2021]
cwe: [CWE-22, CWE-98]
requires: [scope-guard, file-triage, evidence-recorder]
authorization: required
---

# Path Traversal / LFI (read)

## Invoke when
- A param feeds a file read/download/template path.

## Methodology
1. Confirm base dir & any prefix/suffix (extension appended?).
2. Traverse with `../` sequences; adjust depth; defeat filters (encoding, nested, absolute path).
3. Read canonical proof files; then target app secrets (config, keys, source).
4. If the file is interpreted (PHP/JSP) rather than returned raw → route to `file-inclusion-rce`.

## Starter payloads
- `../../../../etc/passwd`, `..%2f..%2f`, `....//....//`, `%2e%2e%2f`, `..%252f` (double),
  Windows `..\..\windows\win.ini`, absolute `/etc/passwd`, null-byte `%00` (legacy).

## False-positive filters
- Reflected literal `../` without directory change ≠ traversal; a WAF 403 ≠ file not readable.

## Chains to
- `file-inclusion-rce`, `crypto-sensitive-data-exposure`, `chain-builder`.
