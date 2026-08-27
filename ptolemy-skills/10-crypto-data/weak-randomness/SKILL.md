---
name: crypto-weak-randomness
description: >-
  Exploit predictable randomness in security tokens (CWE-330/CWE-338): non-CSPRNG or seeded
  generators (Math.random, mt_rand, time-seeded) producing guessable session ids, reset tokens,
  API keys, OTPs, or CSRF tokens. Invoke when token analysis suggests structure/predictability.
  Predicts/forges tokens rather than brute-forcing blindly.
family: 10-crypto-data
type: exploit
owasp: [A02:2021]
cwe: [CWE-330, CWE-338]
requires: [auth-session-token-analysis]
authorization: required
---

# Weak Randomness / Predictable Tokens

## Invoke when
- `auth-session-token-analysis` flags a token as low-entropy/structured/time-correlated.

## Methodology
1. Collect a token sequence with timestamps.
2. Identify the generator (linear congruential, mt19937, time-seed) from output structure.
3. Recover internal state/seed; predict past/future tokens.
4. Forge a valid token for another user/action to prove impact.

## Starter payloads
- mt19937 state recovery from 624 consecutive outputs; time-seed brute over a narrow window.

## False-positive filters
- Apparent pattern in a truncated view of a CSPRNG token is not predictability — require actual prediction of an unseen token.
