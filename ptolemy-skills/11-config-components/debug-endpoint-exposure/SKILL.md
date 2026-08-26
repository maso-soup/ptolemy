---
name: config-debug-endpoint-exposure
description: >-
  Detect exposed debug/diagnostic/config endpoints (A05/CWE-215/CWE-489): Spring Boot Actuator
  (/env,/heapdump,/mappings), Django/Flask debug pages, `.env`/config files, GraphQL introspection
  in prod, phpinfo, server-status, metrics, and stack traces. Invoke when discovery reveals debug
  surfaces. These leak secrets (machineKey, DB creds, tokens) and enable deeper attacks.
family: 11-config-components
type: exploit
owasp: [A05:2021]
cwe: [CWE-215, CWE-489]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Debug / Diagnostic Endpoint Exposure

## Invoke when
- Discovery/fingerprint suggests debug or introspection endpoints are live in a sensitive environment.

## Methodology
1. Probe framework-specific debug routes and confirm they return internal data.
2. Extract secrets: Actuator `/env`,`/configprops` (creds), `/heapdump` (memory→tokens), Django debug
   (settings/SECRET_KEY), `phpinfo()`, `/server-status`, exposed `.env`.
3. Note whether debug mode enables interactive code exec (Werkzeug console PIN).
4. Report the specific leaked secret and its downstream use.

## Starter payloads
- `/actuator/env`, `/actuator/heapdump`, `/.env`, `/debug`, `/__debug__`, `/server-status`, `?debug=true`.

## False-positive filters
- A locked-down actuator (`/actuator` returns only `/health`) is fine — confirm sensitive sub-endpoints are actually exposed.

## Chains to
- `dotnet-deserialization` (machineKey), `crypto-sensitive-data-exposure`, `chain-builder`.
