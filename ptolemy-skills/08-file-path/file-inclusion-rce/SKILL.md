---
name: file-inclusion-rce
description: >-
  Escalate file inclusion to CODE EXECUTION (CWE-98/CWE-94): PHP wrappers (php://filter,
  data://, expect://, phar://), log/session poisoning then inclusion, /proc/self/environ, and
  RFI where remote includes are allowed. Invoke when an include/require or template path is
  attacker-controlled and interpreted (not merely read). Turns LFI into RCE.
family: 08-file-path
type: exploit
owasp: [A03:2021]
cwe: [CWE-98, CWE-94]
requires: [path-traversal-lfi]
authorization: required
---

# File Inclusion → RCE

## Invoke when
- A controllable path is passed to `include`/`require`/template engine (interpreted include).

## Methodology
1. Wrapper RCE: `php://filter` (source disclosure), `data://`/`expect://` (direct exec), `phar://`
   (deserialization trigger with a crafted archive).
2. Poison-then-include: write PHP into a log/session/upload you control, then include that file.
3. `/proc/self/environ` or `/proc/self/fd` inclusion with a poisoned User-Agent.
4. RFI: if `allow_url_include`, include a remote payload.
5. Prove with `id`/marker; avoid destructive commands.

## Starter payloads
- `php://filter/convert.base64-encode/resource=index.php` (read source)
- `data://text/plain;base64,<?php system('id')?>` (b64)
- `/var/log/apache2/access.log` after poisoning UA with `<?php ... ?>`
- `phar://uploaded.phar/x` (with `php-object-injection` gadget).

## False-positive filters
- Include that only reads (echoes) without interpreting = LFI read, not RCE — stays with `path-traversal-lfi`.
