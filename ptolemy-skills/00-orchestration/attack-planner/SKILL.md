---
name: attack-planner
description: >-
  Turns recon output into an ordered attack plan. Invoke after recon (or when new
  surface is mapped) to decide which vulnerability-class triage skills to run and in what
  order, given the tech fingerprint, endpoints, params, auth model, and roles available.
  Prioritizes high-impact/low-noise paths first and records why each class is in or out.
family: 00-orchestration
type: orchestration
owasp: []
cwe: []
requires: [scope-guard]
authorization: required
---

# Attack Planner

## Invoke when
- Recon has produced endpoints/params/tech stack and you must choose next tests.
- Findings change the surface (new role obtained, new endpoint discovered).

## Methodology
1. Build a matrix: {endpoint × param × reflected-context × auth-role} .
2. Map each cell to candidate triage skills (e.g., param in SQL context → `injection-reflection-triage`).
3. Rank by impact × likelihood × signal-cleanliness; prefer passive/observational first.
4. Sequence so cheap oracles (differential/timing) are established before deep exploits.
5. Emit the plan as an ordered queue of `{skill, target, rationale}`.

## False-positive filters
- Don't queue exploit skills before their triage confirms the oracle.

## Chains to
- family triage skills (`*-triage`), then `chain-builder` when primitives accumulate.
