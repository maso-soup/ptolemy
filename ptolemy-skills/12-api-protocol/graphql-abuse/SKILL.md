---
name: api-graphql-abuse
description: >-
  Attack GraphQL-specific weaknesses (API4/API1): introspection left on in prod, field
  suggestion leakage, unbounded nested queries and alias/array-batching for DoS & brute-force
  amplification, batching-based auth/rate-limit bypass, and authorization gaps between fields.
  Invoke on any `/graphql` endpoint. Distinct from graphql-injection (which is a DB/OS sink behind a resolver).
family: 12-api-protocol
type: exploit
owasp: [API4:2023, API1:2023]
cwe: [CWE-770, CWE-400]
requires: [api-spec-harvest]
authorization: required
---

# GraphQL Abuse

## Invoke when
- A GraphQL endpoint is present (`/graphql`, `/graphql`-like, introspection responds).

## Methodology
1. Introspection: dump the schema; if disabled, use field-suggestion ("did you mean") to infer fields.
2. Authorization: test field/mutation-level authz per role (pairs with `bfla`/`idor-bola`).
3. DoS: deeply nested/recursive queries, huge aliasing, array batching → resource exhaustion (bounded probe).
4. Batching bypass: many operations in one request to defeat per-request rate limits / brute OTP.

## Starter payloads
- Introspection `{__schema{types{name fields{name}}}}`; alias batch `q1:login(...) q2:login(...)`;
  nested `{a{b{a{b{...}}}}}` depth probe.

## False-positive filters
- Introspection-disabled + depth-limited + cost-analysis in place = hardened; confirm actual amplification/authz gap.
