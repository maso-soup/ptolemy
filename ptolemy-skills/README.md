# Ptolemy Skill Library — web & API security

A library of **micro-scoped, single-decision-procedure** skills for an autonomous
web/API security agent operating **only under explicit written authorization**
(pentest engagement, bug-bounty scope, CTF, or lab). Every skill assumes scope has
already been validated by `scope-guard` and defers destructive/irreversible actions
to a human.

## Structure

```
Ptolemy-skills/
  _TEMPLATE/SKILL.md      canonical scaffold — copy this to author new skills
  00-orchestration/       planning, chaining, oracle & evidence bookkeeping
  01-recon/               attack-surface discovery & mapping
  02-access-control/      A01 / API1 / API3 / API5
  03-auth-session/        A07 / API2
  04-injection/           A03 (split by oracle; DBMS is a table inside the skill)
  05-deserialization/     A08 + XXE
  06-ssrf-request-layer/  A10 + smuggling / cache
  07-client-side/         XSS family + browser-trust
  08-file-path/           upload / traversal / inclusion
  09-business-logic/      logic & workflow abuse
  10-crypto-data/         A02
  11-config-components/   A05 / A06 / A09
  12-api-protocol/        API Top 10 protocol specifics
  13-util-evasion/        shared oracles, encoders, OOB — DEPENDENCIES of blind skills
  14-report/              write-ups & chain narratives
```

## Design rules (why the split is where it is)

1. **One decision procedure per skill.** Split siblings only when they load different
   *payloads + oracle + tooling flags + false-positive filters*. Merge otherwise.
2. **Detect → Exploit split.** `type: triage` skills are cheap and broad (decide *whether*
   a class applies); `type: exploit` skills are deep and narrow (invoked once the oracle
   fires). Detection is generic within a family; exploitation diverges hard.
3. **Engine/DBMS/framework specifics are lookup tables *inside* a skill**, never their own
   skill (`error-based-sqli` carries the MySQL/MSSQL/PG/Oracle matrix).
4. **Blind techniques never reimplement detection** — they `requires:` a `13-util-evasion`
   oracle (`util-differential-oracle`, `util-timing-oracle`, `util-oast-oob`).

## Frontmatter contract

| field | meaning |
|-------|---------|
| `name` | unique kebab-case; also the invocation handle |
| `description` | **trigger-tuned**: what it does + *when to invoke* + keyword surface the router matches on |
| `family` | directory family |
| `type` | orchestration \| recon \| triage \| exploit \| util \| report |
| `owasp` / `cwe` | mapping for reporting & routing |
| `requires` | other skills this one depends on (oracles/utils) |
| `authorization` | `required` — skill refuses to run until `scope-guard` has approved the target |

## Installation

The repo stores only this authored source. Generate the loader-ready `.claude/skills/`
layout by running the installer from the repo root:

```bash
./install-skills.sh
```

This flattens `ptolemy-skills/<family>/<skill>/SKILL.md` into `.claude/skills/<name>/SKILL.md`
(using the frontmatter `name`, which is globally unique) and copies the whole skill directory
so future reference/asset files travel with it. It's safe to re-run: it tracks what it wrote in
`.claude/skills/.ptolemy-skills-manifest` and only ever refreshes or prunes skills it installed —
hand-made skills in the same directory are left untouched.

Useful flags: `--dry-run` (preview), `--link` (symlink instead of copy, so edits to source reflect
live), `--target DIR` (install into another project), `--uninstall`. See `./install-skills.sh --help`.

`.claude/skills/` is generated output and is gitignored — commit the source, not the build.
Keep `install-skills.sh` at the repo root, as a sibling of `ptolemy-skills/`.
