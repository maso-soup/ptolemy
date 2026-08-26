---
name: auth-oauth-oidc-abuse
description: >-
  Attack OAuth2/OIDC flows: open/loose redirect_uri (token/code theft), missing or replayable
  state (login CSRF), authorization-code injection/replay, PKCE absent or downgradable, implicit-
  flow token leakage, id_token signature/aud/nonce gaps, and scope escalation. Invoke when the
  app delegates login via OAuth/OIDC or a `redirect_uri`/`code`/`state` param is present.
family: 03-auth-session
type: exploit
owasp: [A07:2021, API2:2023]
cwe: [CWE-601, CWE-352]
requires: [scope-guard, evidence-recorder]
authorization: required
---

# OAuth 2.0 / OIDC Abuse

## Invoke when
- Login goes through an authorization server, or you see `client_id`, `redirect_uri`, `code`, `state`.

## Methodology
1. redirect_uri validation: try subdomain, path append, `@`-trick, open-redirect chain, extra params.
2. state: omit/reuse it → login-CSRF / account-linking abuse.
3. code: replay a used code; inject a code obtained for attacker into victim session.
4. PKCE: absent, or `code_challenge_method=plain` downgrade.
5. Response type: force `token`/`id_token` into a URL that leaks via referer/history.
6. id_token: unsigned/`alg` issues, wrong `aud`, missing `nonce` binding.

## Starter payloads
- `redirect_uri=https://app.com.attacker.tld`, `redirect_uri=https://app.com/cb/../open-redirect`,
  drop `state`, replay `code`.

## False-positive filters
- Provider shows consent but strictly matches redirect_uri → not exploitable; confirm token/code lands attacker-side.

## Chains to
- `open-redirect`, `auth-jwt-attacks` (id_token), `chain-builder`.
