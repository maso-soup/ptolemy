---
name: os-command-injection
description: >-
  Exploit OS command injection where command output is reflected (CWE-78): break out of a
  shell invocation with separators and read the result in the response. Invoke when a param
  feeds a system/exec call (ping, convert, pdf, git, filename) and output is visible. For
  no-output cases route to blind-command-injection.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-78]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# OS Command Injection (in-band)

## Invoke when
- A param reaches a shell/exec and command output is reflected to the client.

## Prerequisites & oracle
- Oracle = injected command's stdout appears in the response.

## Methodology
1. Try separators to append a benign command whose output is unmistakable (`id`, `whoami`).
2. Test both `;`/`&&`/`|`/newline and command-substitution `$( )` / backticks.
3. Handle quoting context (inside `"`/`'`) — close it first.
4. Confirm execution (output present), then bound impact (no destructive commands).

## Starter payloads
- `; id`, `&& whoami`, `| cat /etc/passwd`, `$(id)`, `` `id` ``, `%0aid` (newline), `"; id; "`.

## False-positive filters
- Reflected literal payload (not executed) ≠ injection. Require actual command output.

## Chains to
- `blind-command-injection` (no output), `file-inclusion-rce`, `chain-builder`.
