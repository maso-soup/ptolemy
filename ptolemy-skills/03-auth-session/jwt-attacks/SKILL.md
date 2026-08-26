---
name: auth-jwt-attacks
description: >-
  Attack JSON Web Tokens (CWE-347): alg:none/downgrade, RS256→HS256 key-confusion, weak HMAC
  secret cracking, kid path-traversal/SQLi, jku/x5u/jwk header injection, missing exp/aud/iss
  validation, and claim tampering (role/tenant). Invoke whenever a JWT is used for auth/authz.
  DBMS/library specifics are handled inline.
family: 03-auth-session
type: exploit
owasp: [A07:2021, A02:2021]
cwe: [CWE-347, CWE-321]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# JWT Attacks

## Invoke when
- A `Bearer eyJ...`/cookie JWT carries identity or authorization claims.

## Prerequisites & oracle
- Ability to submit a modified token and observe accept/reject. Oracle = tampered token is honored.

## Methodology
1. Decode header+payload; note `alg`, `kid`, `jku`/`jwk`, and claims (`sub,role,exp,aud,iss`).
2. `alg:none` / empty-signature acceptance test.
3. Key confusion: sign with the public key as HMAC secret (RS256→HS256).
4. Weak secret: offline crack HS256 with a wordlist.
5. `kid` injection: path traversal to a known file, or SQLi in kid lookup.
6. `jku`/`x5u`/`jwk` header → point to attacker-hosted key (if server fetches).
7. Claim tampering after any signature bypass (elevate `role`, swap `tenant`).
8. Validation gaps: expired/wrong-`aud`/wrong-`iss` still accepted.

## Starter payloads
- `{"alg":"none"}` + empty sig; `hashcat -m 16500`; `kid:"../../dev/null"`; `jku` → attacker JWKS.

## False-positive filters
- Token accepted but server independently re-checks session → confirm the claim actually drove authz.

## Chains to
- `multi-tenant-isolation`, `bfla`, `crypto-weak-randomness`, `chain-builder`.
