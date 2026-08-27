# Skill Index

Generated inventory of all skills. `type` and OWASP/CWE are read from each SKILL.md frontmatter.

## 01-recon

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `api-spec-harvest` | recon | [API9:2023] | [CWE-200] |
| `content-discovery` | recon | [A05:2021] | [CWE-538] |
| `crawler-authenticated` | recon | [] | [] |
| `js-analysis` | recon | [A05:2021] | [CWE-200] |
| `parameter-mining` | recon | [] | [CWE-233] |
| `passive-osint` | recon | [] | [] |
| `subdomain-enum` | recon | [] | [] |
| `tech-fingerprint` | recon | [A06:2021] | [CWE-200] |

## 02-access-control

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `access-control-triage` | triage | [A01:2021, API1:2023, API5:2023] | [CWE-284, CWE-285] |
| `bfla` | exploit | [A01:2021, API5:2023] | [CWE-285, CWE-862] |
| `forced-browsing` | exploit | [A01:2021] | [CWE-425, CWE-862] |
| `http-method-tampering` | exploit | [A01:2021, API5:2023] | [CWE-650, CWE-285] |
| `idor-bola` | exploit | [A01:2021, API1:2023] | [CWE-639, CWE-566] |
| `mass-assignment` | exploit | [A01:2021, API3:2023] | [CWE-915, CWE-639] |
| `multi-tenant-isolation` | exploit | [A01:2021, API1:2023] | [CWE-639, CWE-284] |
| `path-normalization-bypass` | exploit | [A01:2021, A05:2021] | [CWE-22, CWE-436] |

## 03-auth-session

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `auth-credential-attacks` | exploit | [A07:2021] | [CWE-307, CWE-521] |
| `auth-jwt-attacks` | exploit | [A07:2021, A02:2021] | [CWE-347, CWE-321] |
| `auth-mechanism-triage` | triage | [A07:2021, API2:2023] | [CWE-287] |
| `auth-mfa-bypass` | exploit | [A07:2021] | [CWE-287, CWE-308] |
| `auth-oauth-oidc-abuse` | exploit | [A07:2021, API2:2023] | [CWE-601, CWE-352] |
| `auth-password-reset-abuse` | exploit | [A07:2021] | [CWE-640, CWE-620] |
| `auth-saml-attacks` | exploit | [A07:2021] | [CWE-347, CWE-290] |
| `auth-session-fixation-hijack` | exploit | [A07:2021] | [CWE-384, CWE-613] |
| `auth-session-token-analysis` | exploit | [A07:2021, A02:2021] | [CWE-330, CWE-331] |

## 04-injection

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `blind-boolean-sqli` | exploit | [A03:2021] | [CWE-89] |
| `blind-command-injection` | exploit | [A03:2021] | [CWE-78] |
| `code-injection-eval` | exploit | [A03:2021] | [CWE-94, CWE-95] |
| `error-based-sqli` | exploit | [A03:2021] | [CWE-89] |
| `expression-language-injection` | exploit | [A03:2021] | [CWE-917, CWE-94] |
| `graphql-injection` | exploit | [A03:2021, API3:2023] | [CWE-89, CWE-943] |
| `header-injection` | exploit | [A03:2021] | [CWE-93, CWE-113] |
| `ldap-injection` | exploit | [A03:2021] | [CWE-90] |
| `nosql-injection` | exploit | [A03:2021] | [CWE-943, CWE-89] |
| `oob-sqli` | exploit | [A03:2021] | [CWE-89] |
| `orm-injection` | exploit | [A03:2021] | [CWE-89, CWE-564] |
| `os-command-injection` | exploit | [A03:2021] | [CWE-78] |
| `injection-reflection-triage` | triage | [A03:2021] | [CWE-74, CWE-707] |
| `second-order-sqli` | exploit | [A03:2021] | [CWE-89] |
| `smtp-header-injection` | exploit | [A03:2021] | [CWE-93] |
| `ssti` | exploit | [A03:2021] | [CWE-1336, CWE-94] |
| `time-based-blind-sqli` | exploit | [A03:2021] | [CWE-89] |
| `union-based-sqli` | exploit | [A03:2021] | [CWE-89] |
| `xpath-injection` | exploit | [A03:2021] | [CWE-643] |

## 05-deserialization

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `deserial-triage` | triage | [A08:2021] | [CWE-502] |
| `dotnet-deserialization` | exploit | [A08:2021] | [CWE-502] |
| `java-deserialization` | exploit | [A08:2021] | [CWE-502] |
| `node-prototype-pollution` | exploit | [A08:2021, A03:2021] | [CWE-1321] |
| `php-object-injection` | exploit | [A08:2021] | [CWE-502] |
| `python-pickle-exploit` | exploit | [A08:2021] | [CWE-502] |
| `xxe-attacks` | exploit | [A05:2021, A08:2021] | [CWE-611, CWE-827] |

## 06-ssrf-request-layer

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `host-header-attacks` | exploit | [A05:2021] | [CWE-644] |
| `http-request-smuggling` | exploit | [A05:2021] | [CWE-444] |
| `ssrf-basic` | exploit | [A10:2021] | [CWE-918] |
| `ssrf-blind` | exploit | [A10:2021] | [CWE-918] |
| `ssrf-cloud-metadata` | exploit | [A10:2021] | [CWE-918] |
| `ssrf-filter-bypass` | exploit | [A10:2021] | [CWE-918] |
| `ssrf-triage` | triage | [A10:2021, API7:2023] | [CWE-918] |
| `web-cache-deception` | exploit | [A05:2021] | [CWE-525] |
| `web-cache-poisoning` | exploit | [A05:2021] | [CWE-444, CWE-349] |

## 07-client-side

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `blind-xss` | exploit | [A03:2021] | [CWE-79] |
| `clickjacking` | exploit | [A05:2021] | [CWE-1021] |
| `content-security-policy-bypass` | exploit | [A05:2021] | [CWE-693] |
| `cors-misconfig` | exploit | [A05:2021] | [CWE-942] |
| `csrf` | exploit | [A01:2021] | [CWE-352] |
| `csti` | exploit | [A03:2021] | [CWE-1336, CWE-79] |
| `dangling-markup-exfil` | exploit | [A03:2021] | [CWE-79] |
| `dom-xss` | exploit | [A03:2021] | [CWE-79] |
| `mutation-xss` | exploit | [A03:2021] | [CWE-79, CWE-80] |
| `open-redirect` | exploit | [A01:2021] | [CWE-601] |
| `postmessage-abuse` | exploit | [A03:2021] | [CWE-345, CWE-79] |
| `reflected-xss` | exploit | [A03:2021] | [CWE-79] |
| `stored-xss` | exploit | [A03:2021] | [CWE-79] |
| `xss-context-triage` | triage | [A03:2021] | [CWE-79] |

## 08-file-path

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `file-inclusion-rce` | exploit | [A03:2021] | [CWE-98, CWE-94] |
| `file-triage` | triage | [A01:2021, A05:2021] | [CWE-22, CWE-434] |
| `file-upload-abuse` | exploit | [A05:2021] | [CWE-434] |
| `path-traversal-lfi` | exploit | [A01:2021] | [CWE-22, CWE-98] |

## 09-business-logic

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `coupon-referral-abuse` | exploit | [A04:2021] | [CWE-840, CWE-799] |
| `bizlogic-flow-mapper` | triage | [A04:2021] | [CWE-840, CWE-841] |
| `price-quantity-tampering` | exploit | [A04:2021] | [CWE-472, CWE-840] |
| `race-conditions` | exploit | [A04:2021] | [CWE-362, CWE-367] |
| `rate-limit-bypass` | exploit | [A04:2021, API4:2023] | [CWE-799, CWE-307] |
| `workflow-bypass` | exploit | [A04:2021] | [CWE-840, CWE-841] |

## 10-crypto-data

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `crypto-hash-length-extension` | exploit | [A02:2021] | [CWE-345, CWE-347] |
| `crypto-padding-oracle` | exploit | [A02:2021] | [CWE-347, CWE-696] |
| `crypto-sensitive-data-exposure` | exploit | [A02:2021, API3:2023] | [CWE-200, CWE-213] |
| `crypto-weak-randomness` | exploit | [A02:2021] | [CWE-330, CWE-338] |
| `crypto-weak-tls-config` | exploit | [A02:2021] | [CWE-326, CWE-327] |

## 11-config-components

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `config-cloud-storage-misconfig` | exploit | [A05:2021] | [CWE-284, CWE-732] |
| `config-debug-endpoint-exposure` | exploit | [A05:2021] | [CWE-215, CWE-489] |
| `config-default-creds-exposed-panels` | exploit | [A05:2021, A07:2021] | [CWE-1392, CWE-1188] |
| `dependency-confusion` | exploit | [A06:2021] | [CWE-427, CWE-1104] |
| `components-known-cve-match` | exploit | [A06:2021] | [CWE-1035, CWE-937] |
| `logging-monitoring-gaps` | report | [A09:2021] | [CWE-778, CWE-223] |
| `config-security-header-audit` | exploit | [A05:2021] | [CWE-693, CWE-1021] |
| `subdomain-takeover` | exploit | [A05:2021] | [CWE-350] |

## 12-api-protocol

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `api-graphql-abuse` | exploit | [API4:2023, API1:2023] | [CWE-770, CWE-400] |
| `api-grpc-web-testing` | exploit | [API1:2023, API3:2023] | [CWE-285, CWE-915] |
| `api-improper-inventory` | exploit | [API9:2023] | [CWE-1059] |
| `api-rest-verb-tampering` | exploit | [API5:2023] | [CWE-650, CWE-285] |
| `api-unrestricted-resource-consumption` | exploit | [API4:2023] | [CWE-770, CWE-400] |
| `api-unsafe-consumption` | exploit | [API10:2023] | [CWE-1104, CWE-345] |
| `api-websocket-testing` | exploit | [API2:2023, A01:2021] | [CWE-346, CWE-285] |

## 13-util-evasion

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `util-differential-oracle` | util | [] | [] |
| `util-encoder-polyglot` | util | [] | [] |
| `util-oast-oob` | util | [] | [] |
| `util-timing-oracle` | util | [] | [] |
| `util-waf-bypass` | util | [] | [] |

## 14-report

| skill | type | owasp | cwe |
|-------|------|-------|-----|
| `chain-narrative` | report | [] | [] |
| `finding-writeup` | report | [] | [] |

**Total skills: 111**
