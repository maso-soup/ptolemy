---
name: auth-saml-attacks
description: >-
  Attack SAML SSO assertions: XML signature wrapping (XSW), signature exclusion/stripping,
  comment-injection in NameID (canonicalization abuse), assertion replay, and recipient/audience
  confusion. Invoke when authentication uses SAML (SAMLResponse form field, ACS endpoint,
  IdP metadata). Pairs with XML parser attacks.
family: 03-auth-session
type: exploit
owasp: [A07:2021]
cwe: [CWE-347, CWE-290]
requires: []
authorization: required
---

# SAML Attacks

## Invoke when
- A `SAMLResponse` is posted to an ACS endpoint / SP consumes IdP assertions.

## Methodology
1. Decode/inflate the SAMLResponse; locate Assertion, Signature, NameID.
2. Signature exclusion: remove Signature — is the assertion still accepted?
3. XML Signature Wrapping: add a forged assertion the app reads while signature covers the original.
4. Comment injection: `admin<!---->@evil` in NameID to confuse the parsed identity.
5. Replay: resubmit a captured valid assertion; check NotOnOrAfter/InResponseTo enforcement.

## Starter payloads
- Strip `<ds:Signature>`; wrap forged `<Assertion>` around/above the signed node; `NameID` comment trick.

## False-positive filters
- SP rejects on any tamper (strict schema+sig) → not vulnerable; confirm a forged identity authenticates.
