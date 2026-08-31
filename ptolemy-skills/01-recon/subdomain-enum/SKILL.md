---
name: subdomain-enum
description: >-
  Enumerate and resolve subdomains for in-scope apex domains, then probe which are live and
  their HTTP surface. Invoke after passive-osint to convert candidate names into confirmed
  hosts. Flags dangling CNAMEs for subdomain-takeover. Respects scope wildcards and rate caps.
family: 01-recon
type: recon
owasp: []
cwe: []
requires: []
authorization: required
---

# Subdomain Enumeration

## Invoke when
- You have apex domains and need the live host surface.

## Methodology
1. Merge passive sources + resolver brute (scoped wordlist) → candidate FQDNs.
2. Mass-resolve; keep records + CNAME targets.
3. HTTP-probe live hosts (status, title, tech, redirects).
4. Flag CNAMEs pointing to unclaimed providers → subdomain-takeover candidate.

## Tooling
- `subfinder`/`amass` (passive), `dnsx` (resolve), `httpx` (probe). Honor rate ceiling.
