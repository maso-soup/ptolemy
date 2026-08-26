---
name: config-default-creds-exposed-panels
description: >-
  Find exposed admin/management interfaces and test default/weak credentials (A05/A07):
  Tomcat manager, Jenkins, Grafana, Kibana, phpMyAdmin, router/IoT panels, DB consoles, cloud
  dashboards. Invoke when content-discovery or fingerprinting surfaces a management panel. Tries
  documented vendor defaults only, within scope — a frequent instant-critical.
family: 11-config-components
type: exploit
owasp: [A05:2021, A07:2021]
cwe: [CWE-1392, CWE-1188]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# Default Creds / Exposed Panels

## Invoke when
- A management/admin panel is discovered (from `content-discovery`/`tech-fingerprint`).

## Methodology
1. Identify the product + version → look up documented default credentials.
2. Attempt the vendor defaults (admin/admin, tomcat/tomcat, etc.) within scope + rate cap.
3. If authenticated, confirm privileged capability (deploy, query, config) as proof — no destructive use.
4. Also flag panels reachable at all from the tested position (exposure itself is a finding).

## Starter payloads
- Product-specific default pairs; common `admin:admin`, `admin:password`, blank-password.

## False-positive filters
- A login page's mere presence isn't a finding unless it's improperly exposed for its role; confirm actual access on default creds.

## Chains to
- `forced-browsing`, `components-known-cve-match`, `chain-builder`.
