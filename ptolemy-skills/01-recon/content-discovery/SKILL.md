---
name: content-discovery
description: >-
  Brute/guess hidden paths, files, and endpoints on a confirmed host: backup files
  (.bak/.old/~), VCS exposure (.git/.svn), config/env files, admin panels, API routes.
  Invoke per live host after fingerprinting. Distinguishes real 200s from soft-404s via
  baseline calibration. Sensitive-file hits route straight to evidence-recorder.
family: 01-recon
type: recon
owasp: [A05:2021]
cwe: [CWE-538]
requires: [scope-guard]
authorization: required
---

# Content Discovery

## Invoke when
- A live host/app root is confirmed and you need its hidden surface.

## Methodology
1. Calibrate soft-404: request random path, capture length/status/body fingerprint.
2. Fuzz with a stack-appropriate wordlist (extension-aware for detected tech).
3. Probe high-value specifics: `.git/HEAD`, `.env`, `.DS_Store`, `*.bak`, `swagger.json`,
   `/actuator`, `/.well-known/`.
4. Filter results against the soft-404 fingerprint; recurse into discovered dirs (bounded).

## False-positive filters
- Wildcard responders return 200 for everything → rely on the calibrated fingerprint, not status.

## Tooling
- `ffuf`/`feroxbuster` with `-ac`/auto-calibration; recursion depth capped.

## Chains to
- `api-spec-harvest` (if swagger/openapi found), `parameter-mining`, `config-debug-endpoint-exposure`.
