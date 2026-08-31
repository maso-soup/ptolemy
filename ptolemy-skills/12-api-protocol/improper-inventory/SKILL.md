---
name: api-improper-inventory
description: >-
  Hunt improper API inventory management (API9/CWE-1059): shadow, zombie, deprecated, and
  non-production API versions/hosts that are less protected than the current one (old `/v1` while
  `/v2` is hardened, `staging.`/`dev.` API hosts, undocumented endpoints). Invoke after spec
  harvest/recon to test whether older/parallel versions reintroduce fixed vulns or skip auth.
family: 12-api-protocol
type: exploit
owasp: [API9:2023]
cwe: [CWE-1059]
requires: [api-spec-harvest]
authorization: required
---

# Improper API Inventory (Shadow/Zombie APIs)

## Invoke when
- Multiple API versions/hosts exist, or spec-vs-observed diffs suggest undocumented endpoints.

## Methodology
1. Enumerate versions/hosts (`/v1../vN`, `api-dev`, `staging-api`, internal hostnames from JS/DNS).
2. Compare protections across versions (auth, rate limits, validation) — older often weaker.
3. Re-test known-fixed vulns against old versions; test non-prod hosts for laxer controls/real data.
4. Report each parallel surface and the specific weakness it reintroduces.

## Starter payloads
- Downgrade `/v2/x` → `/v1/x`; swap host to `staging-api.` with prod tokens; probe undocumented routes.

## False-positive filters
- A deprecated version returning 410/hard-blocked is fine; confirm it's live AND weaker.
