---
name: passive-osint
description: >-
  Zero-touch reconnaissance from public sources only. Invoke at the start of engagement or
  when expanding surface without touching the target: certificate transparency, wayback/URL
  archives, public code & paste search for leaked keys, DNS history, ASN/IP ranges. No
  packets to in-scope hosts. Route active probing to subdomain-enum / content-discovery.
family: 01-recon
type: recon
owasp: []
cwe: []
requires: []
authorization: required
---

# Passive OSINT

## Invoke when
- Beginning recon, or you need surface expansion without alerting the target.

## Methodology
1. Cert transparency (crt.sh) → candidate subdomains/hostnames.
2. Wayback/CommonCrawl → historical URLs, dead endpoints, old params.
3. Public code/paste/secret search for org tokens (scope-limited; report only).
4. DNS history + ASN/CIDR to bound the IP surface.

## False-positive filters
- Historical URLs may be dead — mark as candidates, confirm later with active recon.

## Evidence to capture
- Source + retrieval date for each artifact (esp. any leaked secret → report immediately).
