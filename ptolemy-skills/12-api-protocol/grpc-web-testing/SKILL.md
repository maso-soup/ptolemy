---
name: api-grpc-web-testing
description: >-
  Test gRPC / gRPC-Web / Protobuf services (API-layer): recover service definitions via server
  reflection, decode/encode protobuf to manipulate fields, and reach methods/fields the client
  never exposes (authz gaps, mass-assignment analogues). Invoke when traffic is gRPC/protobuf
  (`application/grpc`, `grpc-web`) rather than JSON REST. Turns an opaque binary API into a testable one.
family: 12-api-protocol
type: exploit
owasp: [API1:2023, API3:2023]
cwe: [CWE-285, CWE-915]
requires: []
authorization: required
---

# gRPC / gRPC-Web Testing

## Invoke when
- The service speaks gRPC/gRPC-Web/protobuf (content-type `application/grpc*`).

## Methodology
1. Try server reflection to list services/methods/messages; else recover `.proto` from the client bundle.
2. Craft raw requests with a gRPC client; enumerate methods low-priv roles shouldn't call (BFLA).
3. Tamper protobuf fields (including unknown/reserved) for mass-assignment-style over-posting.
4. Test message-framing/limits for resource abuse.

## Starter payloads
- `grpcurl -plaintext host:port list`; `grpcurl ... describe`; field-tampered message bodies.

## False-positive filters
- Reflection disabled ≠ secure; recover the proto from the client before concluding methods are unreachable.
