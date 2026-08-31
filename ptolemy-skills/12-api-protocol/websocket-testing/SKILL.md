---
name: api-websocket-testing
description: >-
  Test WebSocket security: missing origin validation (Cross-Site WebSocket Hijacking / CSWSH),
  authentication only at handshake, message-level injection/authorization gaps, and tampering of
  JSON/RPC messages over the socket. Invoke when the app uses WebSockets (`ws://`/`wss://`, upgrade
  handshake). Covers both the handshake trust and the per-message attack surface.
family: 12-api-protocol
type: exploit
owasp: [API2:2023, A01:2021]
cwe: [CWE-346, CWE-285]
requires: []
authorization: required
---

# WebSocket Testing

## Invoke when
- A WebSocket connection is established (Upgrade: websocket).

## Methodology
1. Handshake: does it validate `Origin`? If not + cookie auth → CSWSH (attacker page opens the socket).
2. Auth model: is authz only at connect, letting any message through afterward? Test per-message authz.
3. Message tampering: replay/modify JSON/RPC messages (IDOR/injection over the socket).
4. Confirm CSWSH by reading/acting on victim data from an off-origin page.

## Starter payloads
- Off-origin `new WebSocket('wss://target/...')` with credentials; tampered message frames (`{"action":"admin"}`).

## False-positive filters
- Per-message tokens / strict origin checks defeat CSWSH — confirm the off-origin socket actually reads authed data.
