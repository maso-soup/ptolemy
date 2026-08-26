---
name: chain-builder
description: >-
  Composes individual primitives into multi-step exploit chains. Invoke when two or more
  confirmed findings could combine into higher impact (e.g., SSRF + cloud-metadata + creds
  = RCE; open-redirect + OAuth = token theft; IDOR + mass-assignment = privilege escalation).
  Produces the concrete request sequence and the trust boundary each step crosses.
family: 00-orchestration
type: orchestration
owasp: []
cwe: []
requires: [oracle-manager]
authorization: required
---

# Chain Builder

## Invoke when
- ≥2 confirmed primitives exist whose outputs/inputs connect.
- A single finding is low-severity alone but pivotal in a chain.

## Methodology
1. Represent each primitive as {precondition → capability granted}.
2. Search for a path from attacker-start to a high-value goal (RCE, full account takeover,
   data exfil, privilege escalation) where each edge's precondition is met by a prior step.
3. Materialize the shortest viable chain as an ordered, reproducible request script.
4. Note the exact trust boundary crossed per hop for the report's impact narrative.

## Evidence to capture
- End-to-end reproducible sequence + the demonstrated final capability (bounded PoC only).

## Chains to
- `chain-narrative` (report) — narrate the demonstrated chain.
