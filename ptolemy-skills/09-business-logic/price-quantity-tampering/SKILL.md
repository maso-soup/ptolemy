---
name: price-quantity-tampering
description: >-
  Exploit trust in client-supplied price/quantity/currency (CWE-472/CWE-840): negative
  quantities, altered unit prices, currency swaps, rounding abuse, or integer over/underflow in
  cart/checkout/transfer to pay less or credit more. Invoke when amounts, prices, or quantities
  are sent from the client and used server-side without re-derivation.
family: 09-business-logic
type: exploit
owasp: [A04:2021]
cwe: [CWE-472, CWE-840]
requires: [bizlogic-flow-mapper]
authorization: required
---

# Price / Quantity Tampering

## Invoke when
- Checkout/transfer/order requests carry price, amount, quantity, or currency from the client.

## Methodology
1. Modify unit price / total to a lower/zero/negative value; observe if the server honors it.
2. Negative or fractional quantity → credit/refund abuse; huge quantity → integer overflow.
3. Currency/locale swap to a weaker currency at the same nominal amount.
4. Rounding: many tiny transactions exploiting round-down.
5. Confirm the financial effect on a test account; never exceed proof on real value.

## Starter payloads
- `price=0`/`price=-100`, `quantity=-1`, `amount=0.001`, `currency=IDR` with USD nominal,
  `2147483647`+1 quantity (overflow).

## False-positive filters
- Server recomputes price from catalog and ignores client price = safe; confirm the paid/charged amount actually changed.
