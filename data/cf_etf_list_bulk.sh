#!/bin/bash
echo "DELETE CF ETF"
curl -XDELETE localhost:19200/cf_etf
echo " \n"
echo "ADD SETTINGS"
curl -XPUT localhost:19200/cf_etf -H "Content-Type:application/json" --data-binary @define_custom_analyzer.esi.json

echo "\nADD DATA"
curl -XPOST localhost:19200/cf_etf/_bulk?pretty -H "Content-Type:application/json" --data-binary @cf_etf_list_bulk.mjson