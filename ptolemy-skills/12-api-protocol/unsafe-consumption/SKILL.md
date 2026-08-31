---
name: api-unsafe-consumption
description: >-
  Test unsafe consumption of third-party/upstream APIs (API10/CWE-1104): the target blindly
  trusts data from an integrated external API (following its redirects, deserializing its data,
  rendering its content) so that compromising or spoofing the upstream injects into the target.
  Invoke when the app pulls from external providers (payment, social, data feeds, webhooks).
family: 12-api-protocol
type: exploit
owasp: [API10:2023]
cwe: [CWE-1104, CWE-345]
requires: [util-oast-oob]
authorization: required
---

# Unsafe API Consumption

## Invoke when
- The target integrates external APIs/webhooks and processes their responses/content.

## Methodology
1. Map inbound trust: which upstreams feed data into the target, and how it's processed (parse/render/store/exec).
2. Where you control an upstream input (webhook payloads, user-linked third-party data), inject
   classic payloads (XSS/SQLi/SSRF/deserialization) via that channel.
3. Test whether the target follows upstream redirects into internal space (SSRF-by-proxy).
4. Confirm the injected data reaches a sink in the target.

## Starter payloads
- Malicious webhook body with stored-XSS/injection; upstream redirect → `169.254.169.254`.

## False-positive filters
- Data that's strictly validated on ingestion is safe — confirm the untrusted upstream value hits a real sink.
