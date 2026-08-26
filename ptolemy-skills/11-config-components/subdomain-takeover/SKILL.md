---
name: subdomain-takeover
description: >-
  Confirm subdomain takeover (CWE-350): a DNS record (CNAME/A) points to a de-provisioned
  third-party service (GitHub Pages, S3, Heroku, Azure, etc.) that an attacker can claim, taking
  control of the subdomain. Invoke when subdomain-enum flags a dangling CNAME or a fingerprint
  page says the resource is unclaimed. Confirms claimability via the provider's takeover signature.
family: 11-config-components
type: exploit
owasp: [A05:2021]
cwe: [CWE-350]
requires: [scope-guard, subdomain-enum, evidence-recorder]
authorization: required
---

# Subdomain Takeover

## Invoke when
- A subdomain's CNAME/A points to a third-party service returning an "unclaimed/no such app" page.

## Methodology
1. Resolve the record and identify the target provider.
2. Match the provider's takeover fingerprint (specific 404/"NoSuchBucket"/"There isn't a GitHub Pages site").
3. Confirm claimability per provider docs — WITHOUT actually registering, unless explicitly authorized.
4. Report the dangling record + provider + claim procedure.

## Starter payloads
- Provider fingerprint strings (e.g., S3 `NoSuchBucket`, GitHub `There isn't a GitHub Pages site here`).

## Do not invoke to
- Register/claim the resource unless the engagement explicitly authorizes claiming — otherwise report only.

## Chains to
- `cors-misconfig` (trusted-subdomain abuse), `auth-oauth-oidc-abuse`, `chain-builder`.
