---
name: util-encoder-polyglot
description: >-
  Shared encoding, decoding, and polyglot-construction helper. Invoke from any skill to encode a
  payload for a specific context (URL/HTML/JS/base64/hex/unicode, nested/multi-layer) or to build
  a polyglot that survives multiple parsing contexts at once. Ensures payloads reach the sink
  intact through the exact decode chain the target applies. A dependency of the exploit skills.
family: 13-util-evasion
type: util
owasp: []
cwe: []
requires: []
authorization: required
---

# Encoder / Polyglot Builder (util)

## Invoke when
- A payload must survive a known transform chain, or one payload must work across contexts.

## Methodology
1. Model the target's decode order (e.g., URL-decode then HTML-render then JS-parse).
2. Pre-encode so the payload is correct AFTER all decodes (encode in reverse order).
3. For polyglots, compose a string valid/executing in multiple contexts (HTML+JS+attribute).
4. Return the encoded/polyglot payload to the caller.

## Starter payloads
- Layered: `%2522` (double URL→`%22`→`"`); JS-in-attr polyglot
  `jaVasCript:/*-/*` + `/**/onerror=alert()//` style; classic all-context XSS polyglot.
