---
name: oracle-manager
description: >-
  Bookkeeping for detection oracles. Invoke to register, query, or invalidate the live
  oracles per endpoint/param (baseline response, timing baseline, boolean-true/false
  fingerprints, OAST callback tokens). Blind-exploit skills query this instead of
  re-establishing baselines, preventing drift and duplicate probing.
family: 00-orchestration
type: orchestration
owasp: []
cwe: []
requires: []
authorization: required
---

# Oracle Manager

## Invoke when
- A util oracle skill establishes a baseline (store it here keyed by target+param).
- A blind-exploit skill needs the current baseline/true-false fingerprint.
- Server behavior shifts (rate limiting, WAF, deploy) — invalidate stale baselines.

## Methodology
1. Key oracles by {method, url, param, session-role}.
2. Store: canonical baseline response hash, length, timing p50/p90, boolean fingerprints,
   active OAST correlation IDs.
3. Serve reads to blind skills; expire on detected drift; log every mutation.

## Chains to
- any `blind-*` / `time-based-*` / `oob-*` exploit skill.
