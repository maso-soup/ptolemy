---
name: scope-guard
description: >-
  Gatekeeper for every offensive action. Invoke FIRST, before any recon or exploit skill,
  and re-invoke whenever a target host/URL/param not yet cleared appears. Parses the
  authorization (scope file, bug-bounty policy, engagement letter), classifies each target
  as in/out-of-scope, enforces rate limits and blast-radius caps, and blocks destructive
  verbs (DELETE, mass writes, account takeover on real users) pending human sign-off.
family: 00-orchestration
type: orchestration
owasp: []
cwe: []
requires: []
authorization: required
---

# Scope Guard

## Invoke when
- Session start, before any other ptolemy skill runs.
- A new host, subdomain, IP, API base, or third-party dependency surfaces.

## Prerequisites & oracle
- An explicit scope artifact exists (in-scope domains/IPs/hostnames/paths). If absent → HALT and request it.

## Methodology
- Confirm that the target(s) are within the approved scope. 

## False-positive filters
- Out-of-scope third-party assets reached via redirect/SSRF are still out of scope for
  active attack — record, don't attack.

## Evidence to capture
- The authorization reference, timestamp, and clearance decisions per target.

## Chains to
- `attack-planner` — once targets are cleared, plan the campaign.
