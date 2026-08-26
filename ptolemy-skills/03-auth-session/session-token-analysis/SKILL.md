---
name: auth-session-token-analysis
description: >-
  Assess the randomness/predictability of session ids, reset tokens, API keys, and object
  ids. Invoke when a security-relevant token's generation looks structured (sequential,
  timestamp-seeded, short, or encoding of known data). Collects samples and evaluates entropy
  before recommending brute/predict attacks to other skills.
family: 03-auth-session
type: exploit
owasp: [A07:2021, A02:2021]
cwe: [CWE-330, CWE-331]
requires: [scope-guard, oracle-manager]
authorization: required
---

# Session / Token Randomness Analysis

## Invoke when
- A token is short, monotonic, base64-of-something, or otherwise looks non-random.

## Methodology
1. Collect a sample set (issue many tokens where scope allows).
2. Decode layers (base64/hex/urlencode); look for embedded id/timestamp/counter.
3. Estimate entropy; test for sequential/time correlation.
4. If predictable → hand off with the prediction model.

## False-positive filters
- High-entropy prefix + structured suffix can still be safe if the entropic part gates access.

## Chains to
- `crypto-weak-randomness`, `idor-bola` (predictable object ids), `auth-password-reset-abuse`.
