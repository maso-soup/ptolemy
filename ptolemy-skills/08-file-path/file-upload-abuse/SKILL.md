---
name: file-upload-abuse
description: >-
  Exploit unrestricted/weak file upload (CWE-434): bypass content-type/extension/magic-byte
  checks to store an executable or dangerous file (webshell, SVG-XSS, polyglot, XXE-carrying
  OOXML) and reach an execution/serving path. Invoke when the app accepts uploads. Success
  requires both a stored dangerous file AND a way to trigger/serve it.
family: 08-file-path
type: exploit
owasp: [A05:2021]
cwe: [CWE-434]
requires: [file-triage]
authorization: required
---

# File Upload Abuse

## Invoke when
- An upload endpoint exists (avatar, document, import, attachment).

## Methodology
1. Map validation: extension allow/deny, content-type check, magic-byte check, image re-encoding,
   storage location, and whether uploads are served/executed.
2. Bypass layered: double extension (`.php.jpg`), null byte, case, alt exec extensions
   (`.phtml/.phar/.asp;.jpg`), content-type spoof, magic-byte prefix, polyglot (valid image + code).
3. Find the serve/exec path (predict the stored URL, or an include that runs it).
4. Confirm code exec or the specific impact (SVG→stored XSS, OOXML→XXE) with a marker.

## Starter payloads
- Webshell `<?php system($_GET['c']);?>` as `shell.php.jpg` / `.phtml`; GIF/PHP polyglot;
  SVG with `<script>` for stored XSS; XLSX/DOCX carrying an XXE DTD.

## False-positive filters
- Stored-but-never-served/executed file = limited impact; image re-encoding strips polyglots — verify the stored bytes.
