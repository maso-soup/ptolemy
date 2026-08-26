---
name: js-analysis
description: >-
  Statically mine client-side JavaScript bundles for endpoints, API routes, secrets/keys,
  feature flags, DOM sinks, and postMessage handlers. Invoke when an SPA or JS-heavy app is
  in scope. Surfaces server routes never linked in HTML and client-side sinks that seed
  dom-xss / postmessage-abuse triage.
family: 01-recon
type: recon
owasp: [A05:2021]
cwe: [CWE-200]
requires: [scope-guard]
authorization: required
---

# JS Analysis

## Invoke when
- App is an SPA / ships large JS bundles / has inline scripts worth mining.

## Methodology
1. Collect all scripts (linked + inline + sourcemaps if exposed).
2. Regex/AST extract: URLs, API paths, cloud endpoints, tokens, `apiKey`-like strings.
3. Locate DOM sinks (`innerHTML`, `eval`, `document.write`, `location`) and their sources.
4. Locate `addEventListener('message', ...)` handlers lacking origin checks.

## False-positive filters
- Keys in client code may be intentionally public (e.g., publishable keys) — classify before reporting.

## Chains to
- `dom-xss`, `postmessage-abuse`, `content-discovery` (new routes), `crypto-sensitive-data-exposure`.
