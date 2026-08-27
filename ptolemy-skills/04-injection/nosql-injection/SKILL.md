---
name: nosql-injection
description: >-
  Exploit NoSQL injection (MongoDB and similar): operator injection ($ne/$gt/$regex/$where),
  JSON-type confusion turning a string param into a query object, and JS execution via $where.
  Invoke when the backend is a document store (Mongo/Couch) or a param is parsed as JSON/BSON.
  Auth bypass via `{"$ne":null}` is the classic first probe.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-943, CWE-89]
requires: [util-differential-oracle]
authorization: required
---

# NoSQL Injection

## Invoke when
- Backend is a document DB, or a JSON body param could be coerced into a query operator/object.

## Methodology
1. Type-confusion: send the param as an object instead of a string (`user[$ne]=` / `{"user":{"$ne":null}}`).
2. Auth bypass: `{"username":{"$gt":""},"password":{"$ne":""}}`.
3. Boolean/regex extraction: `{"pwd":{"$regex":"^a"}}` binary-search per char (uses differential oracle).
4. `$where`/`mapReduce` JS injection where enabled → expression/timing oracle.

## Starter payloads
- `username[$ne]=x&password[$ne]=x` (form); `{"$where":"sleep(3000)"}`; `{"field":{"$regex":"^s"}}`.

## False-positive filters
- Frameworks that stringify objects neutralize `$`-operators — confirm the operator actually reached the query.

## Tooling
- `nosqlmap`; custom regex-oracle extractor.
