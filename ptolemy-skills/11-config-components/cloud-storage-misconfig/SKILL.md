---
name: config-cloud-storage-misconfig
description: >-
  Detect misconfigured cloud object storage (A05/CWE-284): public-readable/writable S3 buckets,
  GCS/Azure blobs, listable directories, and predictable bucket names tied to the target. Invoke
  when the app references cloud storage (asset URLs, upload targets) or a bucket name is inferable.
  Public write is critical (content injection); public read leaks data.
family: 11-config-components
type: exploit
owasp: [A05:2021]
cwe: [CWE-284, CWE-732]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Cloud Storage Misconfiguration

## Invoke when
- Asset URLs reveal a bucket/blob, or bucket names are guessable from the org/app.

## Methodology
1. Enumerate candidate bucket/container names (org, app, env permutations).
2. Test anonymous list, read, and write ACLs (and ACL-read).
3. Public write → upload a benign marker (no defacement) to prove; public read → note exposed objects.
4. Check for signed-URL leaks and overly long expiries.

## Starter payloads
- `curl https://<bucket>.s3.amazonaws.com/` (list), `PUT` a marker object; GCS/Azure equivalents.

## False-positive filters
- A bucket serving intended public assets isn't a finding unless it also exposes private objects or allows write.

## Chains to
- `crypto-sensitive-data-exposure`, `stored-xss` (if served as app content), `chain-builder`.
