---
name: dotnet-deserialization
description: >-
  Exploit insecure .NET deserialization (CWE-502): BinaryFormatter/LosFormatter/Json.NET
  TypeNameHandling/ViewState (unprotected or with leaked machineKey) leading to RCE. Invoke
  when .NET serialized data or a `__VIEWSTATE` is accepted, or a machineKey is exposed. Uses
  ysoserial.net gadgets; ViewState needs valid keys or MAC-disabled.
family: 05-deserialization
type: exploit
owasp: [A08:2021]
cwe: [CWE-502]
requires: [scope-guard, util-oast-oob, evidence-recorder]
authorization: required
---

# .NET Deserialization

## Invoke when
- `__VIEWSTATE`/BinaryFormatter/Json.NET(`$type`) input is deserialized, or machineKey leaked.

## Methodology
1. Identify the formatter (ViewState vs BinaryFormatter vs Json.NET TypeNameHandling).
2. ViewState: check MAC — if disabled, or machineKey known (from config leak), forge payload.
3. Generate a ysoserial.net gadget for the formatter; OOB-confirm first.
4. Escalate to command exec with a marker.

## Starter payloads
- `ysoserial.net -g TypeConfuseDelegate -f BinaryFormatter -c "cmd"`
- ViewState (keys known): `-p ViewState --generator=... --validationkey=... --validationalg=...`
- Json.NET: `{"$type":"System.Windows.Data.ObjectDataProvider, ...", ...}`.

## False-positive filters
- ViewState MAC enabled + unknown keys = not forgeable; pivot to finding the machineKey leak first.

## Chains to
- `config-debug-endpoint-exposure` (machineKey/web.config leak), `chain-builder`.
