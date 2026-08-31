---
name: skill-name-kebab
description: >-
  ONE sentence on what it does, then the invoke-triggers. Pack the keyword surface a
  router would match: symptom ("reflected input in HTML body"), artifact ("Set-Cookie
  without HttpOnly"), and intent ("exploit stored XSS"). Say when NOT to invoke and
  where to route instead. This field is the whole reason the skill fires at the right moment.
family: 04-injection
type: triage            # recon | triage | exploit | util
owasp: []               # e.g. [A03:2021]
cwe: []                 # e.g. [CWE-89]
requires: []            # e.g. [util-differential-oracle]
authorization: required
---

# Title

## Invoke when
- concrete symptom / artifact / intent that should fire this skill

## Do not invoke when
- overlap conditions; route to `other-skill` instead

## Prerequisites & oracle
- the exact signal that confirms this class applies (what makes it true/false)

## Methodology
1. deterministic steps, escalation-ordered (cheapest & safest first)

## Starter payloads
- real, minimal payloads; note the variable to fuzz

## False-positive filters
- what mimics a hit but isn't; how to rule it out

## Tooling
- concrete commands / flags

## Evidence to capture
- what proves the finding for the report

## Chains to        # TRIAGE SKILLS ONLY — delete this section for exploit/util/recon skills
- `exploit-skill` — the specific exploit this triage routes to once the oracle is confirmed
