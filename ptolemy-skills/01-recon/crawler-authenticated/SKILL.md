---
name: crawler-authenticated
description: >-
  Stateful, authenticated spidering that maintains a valid session and maps the app per
  role. Invoke when credentials/roles are available to enumerate the true authenticated
  surface (and to build the low-priv vs high-priv endpoint sets that access-control skills
  diff). Avoids logout links and destructive actions.
family: 01-recon
type: recon
owasp: []
cwe: []
requires: []
authorization: required
---

# Authenticated Crawler

## Invoke when
- You hold session(s) for one or more roles and need the post-login surface map.

## Methodology
1. Authenticate; detect session invalidation to keep the session alive.
2. Crawl breadth-first, honoring scope; exclude logout/delete/irreversible controls.
3. Record forms, params, and per-role reachability.
4. Produce role→endpoint sets (feeds BOLA/BFLA diffing).

## False-positive filters
- Session drop mid-crawl yields false 401/403 — re-auth and re-verify before recording.
