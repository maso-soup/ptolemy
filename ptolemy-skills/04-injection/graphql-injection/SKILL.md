---
name: graphql-injection
description: >-
  Exploit injection THROUGH GraphQL resolver arguments — SQL/NoSQL/OS/command payloads passed
  via GraphQL variables into an unsafe backend query (CWE-89/943/78). Invoke when a GraphQL
  field's argument reaches a database/shell. Distinct from api-graphql-abuse (which covers
  introspection/DoS/authorization); this one is about the classic injection sink behind a resolver.
family: 04-injection
type: exploit
owasp: [A03:2021, API3:2023]
cwe: [CWE-89, CWE-943]
requires: [scope-guard, injection-reflection-triage, evidence-recorder]
authorization: required
---

# GraphQL Resolver Injection

## Invoke when
- A GraphQL argument (filter, id, search) plausibly reaches SQL/NoSQL/OS on the resolver side.

## Methodology
1. Enumerate arguments per field (from introspection / `api-spec-harvest`).
2. Inject the classic metacharacters into each argument via variables (typed inputs matter).
3. Classify the resulting sink (SQL error, boolean/time, OS output) and route to the matching
   injection exploit skill, but keep the GraphQL transport.
4. Mind aliasing/batching to iterate blind extraction efficiently.

## Starter payloads
- `query{ user(id:"1' OR '1'='1") { name } }`
- variable form: `{"id":{"$ne":null}}` (NoSQL), `1) UNION SELECT ...` in a filter string.

## False-positive filters
- GraphQL type coercion may reject strings for Int args — match the schema type before concluding.

## Chains to
- `error-based-sqli`/`blind-boolean-sqli`/`nosql-injection` (the actual sink), `api-graphql-abuse`.
