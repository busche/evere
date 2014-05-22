#!/bin/bash

query="$*"
if [ 'x'"$query" = 'x' ]; then
	echo "need a query..."
	exit 1
fi

url=http://172.16.102.39:7474/db/data/transaction/commit
#url=http://127.0.0.1:7474/db/data/transaction/commit

curl -H "Content-Type: application/json" \
	-H "Accept: application/json; charset=UTF-8" \
	-d '{  "statements" : [ {  "statement" : "'"${query}"'" }]}' "${url}"
echo ""

