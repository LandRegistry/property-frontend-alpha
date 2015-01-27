#!/bin/bash

set -e

rm -rf diff2*
rm -rf tmpimg*
rm -rf sshot*

bundle install


export CASEWORK_FRONTEND_DOMAIN="http://casework.landregistryconcept.co.uk"
export PROPERTY_FRONTEND_DOMAIN="http://www.gov.uk.landregistryconcept.co.uk"
export MINT_API_DOMAIN="http://lr-mint.herokuapp.com"
export LR_SEARCH_API_DOMAIN="http://lr-search-api.herokuapp.com"
export SYSTEM_OF_RECORD_API_DOMAIN="http://lr-system-of-record.herokuapp.com"
export SERVICE_FRONTEND_DOMAIN="http://land.service.gov.uk.landregistryconcept.co.uk"
export LR_FIXTURES_URL="http://lr-fixtures.herokuapp.com"
export CASES_URL="http://lr-cases.herokuapp.com"
export INTRODUCTIONS_DOMAIN="http://lr-introduction-service.herokuapp.com"

export ENVIRONMENT="preview"

if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed  --tags ~@performance_test --format json --out report.json --format pretty
else
    cucumber -r features $1
fi
