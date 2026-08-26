---
name: multi-tenant-isolation
description: >-
  Test cross-tenant data isolation in multi-tenant SaaS: whether tenant A can read/write
  tenant B's data by swapping tenant identifiers (subdomain, tenant_id, org header, JWT
  claim). Invoke when the app is multi-tenant and tenancy is carried in a tamperable channel.
  Distinct from single-user IDOR — the boundary is the whole organization.
family: 02-access-control
type: exploit
owasp: [A01:2021, API1:2023]
cwe: [CWE-639, CWE-284]
requires: [scope-guard, idor-bola, evidence-recorder]
authorization: required
---

# Multi-Tenant Isolation

## Invoke when
- Tenancy is expressed via subdomain, `tenant_id`/`org_id` param, header, or JWT claim.

## Methodology
1. Identify where tenancy is carried and whether the server derives vs trusts it.
2. With tenant-A creds, set tenant-B's identifier in each channel.
3. Attempt read then bounded write of B's resources.
4. Test the aggregation endpoints (search/reports) for cross-tenant leakage.

## Starter payloads
- `tenant_id=B`, `X-Org-Id: B`, `Host: b.app.com` with A's session, JWT `org` claim swap
  (pair with `auth-jwt-attacks` if signed).

## False-positive filters
- Server re-derives tenant from session and ignores the tamper → not isolation break; confirm B-data actually returns.

## Chains to
- `auth-jwt-attacks`, `mass-assignment`, `chain-builder`.
