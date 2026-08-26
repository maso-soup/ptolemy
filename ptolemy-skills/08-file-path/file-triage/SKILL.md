---
name: file-triage
description: >-
  Entry point for file & path vulnerabilities. Invoke when a param references a filename/path,
  when an upload feature exists, or when content is included/rendered from a path. Determines
  whether the vector is read (traversal/LFI), write/execute (upload), or inclusion→RCE, and
  routes accordingly.
family: 08-file-path
type: triage
owasp: [A01:2021, A05:2021]
cwe: [CWE-22, CWE-434]
requires: [scope-guard]
authorization: required
---

# File / Path Triage

## Invoke when
- A param looks like a path/filename, or upload/download/include features are present.

## Methodology
1. Read vector (download/view/template path param) → `path-traversal-lfi`.
2. Write vector (upload) → `file-upload-abuse`.
3. Include/execute vector (LFI on interpreted content, wrappers, `include()`) → `file-inclusion-rce`.
4. Note the OS (path separators, `/etc/passwd` vs `win.ini`) for payload selection.

## Chains to
- `path-traversal-lfi`, `file-upload-abuse`, `file-inclusion-rce`.
