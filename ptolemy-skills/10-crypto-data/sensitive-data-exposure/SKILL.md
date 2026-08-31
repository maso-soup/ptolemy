---
name: crypto-sensitive-data-exposure
description: >-
  Detect sensitive-data exposure (A02/CWE-200): PII, secrets, tokens, internal identifiers, or
  full objects over-returned in API responses, error messages, headers, source maps, caches, or
  logs. Invoke while reviewing any response corpus (esp. API3 excessive data exposure). Focuses
  on what shouldn't be there, not on decrypting — often the highest-value low-effort finding.
family: 10-crypto-data
type: exploit
owasp: [A02:2021, API3:2023]
cwe: [CWE-200, CWE-213]
requires: []
authorization: required
---

# Sensitive Data Exposure

## Invoke when
- Reviewing responses/errors/headers/JS for data that shouldn't be exposed to this client/role.

## Methodology
1. Scan API responses for over-returned fields (password hashes, tokens, other users' PII, internal flags)
   — API3 excessive data exposure even when the UI hides them.
2. Trigger verbose errors/stack traces revealing paths, versions, queries, secrets.
3. Check headers/comments/source maps/`.js` for keys and internal endpoints.
4. Check caching of sensitive responses; check exports/backups.
5. Classify data type + who can reach it for severity.

## False-positive filters
- Public/intended data isn't exposure; a "secret"-looking value may be a publishable key — classify before reporting.
