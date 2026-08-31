---
name: ssrf-blind
description: >-
  Exploit blind SSRF (no reflected response) via OOB confirmation and inferential techniques
  (CWE-918): prove the server-side request with a collaborator callback, then infer internal
  reachability from timing/status differences. Invoke when SSRF is suspected but content isn't
  returned. Establishes impact even without readable responses.
family: 06-ssrf-request-layer
type: exploit
owasp: [A10:2021]
cwe: [CWE-918]
requires: [ssrf-triage, util-oast-oob, util-timing-oracle]
authorization: required
---

# Blind SSRF

## Invoke when
- SSRF is suspected but the fetched body is never returned.

## Methodology
1. OOB proof: target a unique collaborator; confirm the DNS+HTTP callback (server-side IP).
2. Internal reachability: infer open vs closed internal ports from response-time/status diffs.
3. Exploit blind-only sinks: trigger internal webhooks, cache purges, or admin actions that
   don't need a response body.

## Starter payloads
- `http://<uuid>.collab.tld/` (proof); internal `http://127.0.0.1:PORT` timing probes.

## False-positive filters
- DNS callback but no HTTP callback = DNS resolution only (limited); grade impact accordingly.
