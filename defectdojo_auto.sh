#!/bin/bash

# Author: Ramazan YETIS

if [[ $# -eq 6 ]] ; then

    DD_IP=$1
    DD_TOKEN=$2
    DD_PRODUCT_NAME=$3
    DD_ENGAGEMENT_NAME=$4
    DD_ENGAGEMENT_NUMBER=$5
    FILE_NAME=$6

    curl -X "POST" http://$DD_IP:8080/api/v2/import-scan/ \
              -H "accept: application/json" \
              -H "Authorization: Token $DD_TOKEN" \
              -H "Content-Type: multipart/form-data" \
              -H "X-CSRFToken: L9t5BQ1srWBzz8utQXg5VVz1bchx3q60yQDASUa9zfT6s0KXzbDCalLExplTXuP8" \
              -F "minimum_severity=Medium" \
              -F "active=true" \
              -F "verified=false" \
              -F "scan_type=OpenVAS CSV" \
              -F "file=@$FILE_NAME;type=text/csv" \
              -F "product_type_name=Software" \
              -F "product_name=$DD_PRODUCT_NAME" \
              -F "engagement_name=$DD_ENGAGEMENT_NAME" \
              -F "engagement=$DD_ENGAGEMENT_NUMBER" \
              -F "close_old_findings=false" \
              -F "push_to_jira=false"

    echo "[INFO] Report was sent to DefectDojo"
else
    echo "Usage: $0 <DEFECTDOJO_IP> <DEFECTDOJO_TOKEN> <PRODUCT_NAME> <ENGAGEMENT_NAME> <ENGAGEMENT_NUMBER> <FILE_NAME>"
    exit 1
fi
