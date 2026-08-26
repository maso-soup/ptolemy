---
name: ssrf-basic
description: >-
  Exploit in-band SSRF where the fetched response is reflected: enumerate internal services,
  ports, and read internal-only endpoints (CWE-918). Invoke when SSRF is confirmed and the
  server returns the fetched content. Maps the internal network and pulls internal admin/API
  responses through the server.
family: 06-ssrf-request-layer
type: exploit
owasp: [A10:2021]
cwe: [CWE-918]
requires: [scope-guard, ssrf-triage, evidence-recorder]
authorization: required
---

# SSRF (in-band)

## Invoke when
- SSRF confirmed AND fetched response bodies are reflected to you.

## Methodology
1. Sweep internal ranges/ports (`127.0.0.1`, `169.254.x`, `10./172./192.168.`) via the param.
2. Read internal-only services (admin panels, dashboards, Redis/Elastic HTTP, k8s API).
3. Fetch `file://` where the fetcher allows it.
4. Bound the sweep to scope; record reachable internal services.

## Starter payloads
- `http://127.0.0.1:PORT/`, `http://localhost/admin`, `http://[::1]/`, `file:///etc/passwd`,
  `http://169.254.169.254/` (→ route to cloud-metadata skill).

## False-positive filters
- Distinguish "connection refused" (closed) vs "timeout" (filtered) vs "200" (open) for accurate mapping.

## Chains to
- `ssrf-cloud-metadata`, `chain-builder` (pivot to discovered internal services).
