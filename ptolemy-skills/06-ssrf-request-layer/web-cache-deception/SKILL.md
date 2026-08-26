---
name: web-cache-deception
description: >-
  Exploit web cache deception (CWE-525): trick the cache into storing a victim's authenticated,
  private response under a path that looks static (e.g., `/account/profile.css`), then retrieve
  it as an attacker. Invoke when a CDN caches by extension/path pattern and dynamic pages can be
  suffixed. Distinct from poisoning — here you steal cached private data.
family: 06-ssrf-request-layer
type: exploit
owasp: [A05:2021]
cwe: [CWE-525]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Web Cache Deception

## Invoke when
- Cache rules key on file extension/path, and dynamic endpoints accept extra path suffixes.

## Methodology
1. Confirm the cache stores by extension/static-looking path.
2. Access an authenticated page with a static-looking suffix (`/account.css`, `/account/foo.jpg`).
3. Check whether the private response got cached (retrieve it unauthenticated / as another user).
4. Demonstrate with a test account's own data to prove the mechanism safely.

## Starter payloads
- `/my-account` → `/my-account/nonexistent.css`, `/api/me/x.js`.

## False-positive filters
- `Cache-Control: private/no-store` on the dynamic response prevents this — verify it's actually cached.

## Chains to
- `crypto-sensitive-data-exposure`, `chain-builder`.
