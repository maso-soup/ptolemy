---
name: orm-injection
description: >-
  Exploit ORM-layer injection: unsafe use of ORM query builders/raw fragments (Hibernate HQL,
  Django `.extra()`/`raw()`, Sequelize/TypeORM raw, ActiveRecord string conditions) that reopen
  SQL injection despite an ORM (CWE-89). Invoke when a param flows into an ORM filter that
  concatenates rather than parameterizes, or into HQL/JPQL.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-89, CWE-564]
requires: [scope-guard, injection-reflection-triage, evidence-recorder]
authorization: required
---

# ORM Injection

## Invoke when
- Input reaches an ORM raw/where fragment or HQL/JPQL/QueryDSL string.

## Methodology
1. Identify the ORM (fingerprint/stack) and its known unsafe APIs.
2. Probe HQL/JPQL-specific syntax (object-path, not raw table names) vs raw-SQL fallthrough.
3. Apply SQL oracle techniques adapted to the dialect the ORM emits.
4. For HQL: leverage `WHERE`-clause injection & subselects against mapped entities.

## Starter payloads
- ActiveRecord: `?sort=name; DROP...` where `order(params[:sort])` (unsafe) — demonstrate read only.
- HQL: `' OR '1'='1`, `x' AND SUBSTRING(...,1,1)='a`.
- Sequelize raw: `1 OR 1=1`.

## False-positive filters
- Parameterized ORM calls neutralize payloads — confirm the concatenated/raw path is actually hit.

## Chains to
- the matching `*-sqli` skill for extraction, `chain-builder`.
