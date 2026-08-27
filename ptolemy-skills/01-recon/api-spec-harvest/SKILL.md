---
name: api-spec-harvest
description: >-
  Discover and parse API contracts — OpenAPI/Swagger, GraphQL introspection, WSDL, gRPC
  reflection, Postman collections — into a normalized endpoint/param/auth inventory. Invoke
  whenever a spec URL is found or an API base is suspected. Turns an opaque API into an
  enumerated, testable surface and reveals undocumented/legacy versions.
family: 01-recon
type: recon
owasp: [API9:2023]
cwe: [CWE-200]
requires: []
authorization: required
---

# API Spec Harvest

## Invoke when
- swagger.json/openapi.yaml, `/graphql`, WSDL, or a Postman collection is found or suspected.

## Methodology
1. Fetch/parse the spec → {method, path, params, body schema, auth scheme, roles}.
2. GraphQL: run introspection (or field-suggestion inference if disabled).
3. Diff documented vs observed routes → shadow/zombie/legacy versions (API9).
4. Emit a normalized endpoint/param/auth inventory for downstream testing.

## False-positive filters
- Spec may describe endpoints that are gated/removed — confirm reachability before testing.
