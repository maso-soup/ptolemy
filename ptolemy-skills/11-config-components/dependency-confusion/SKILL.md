---
name: dependency-confusion
description: >-
  Assess software-supply-chain exposure to dependency confusion / substitution (A06/CWE-427):
  internal package names leaked in source maps, lockfiles, or errors that are unclaimed on public
  registries (npm/PyPI/Maven/NuGet), enabling a malicious public package to be pulled. Invoke when
  build artifacts reveal internal package names. Report-only: identify claimable names; never publish.
family: 11-config-components
type: exploit
owasp: [A06:2021]
cwe: [CWE-427, CWE-1104]
requires: [scope-guard, js-analysis, evidence-recorder]
authorization: required
---

# Dependency Confusion

## Invoke when
- Internal/private package names appear in bundles, source maps, lockfiles, or error output.

## Methodology
1. Extract internal package names + registries used.
2. Check whether each name is unclaimed on the corresponding public registry (higher-version pull risk).
3. Report claimable names and scope/namespace gaps — as a finding.

## Do not invoke to
- Actually publish a package to a public registry — that is an out-of-scope real-world action. HALT and report.

## False-positive filters
- Scoped/namespaced packages (`@org/pkg`) with registry pinning are protected — confirm the resolution actually falls back to public.

## Chains to
- `finding-writeup` (supply-chain risk).
