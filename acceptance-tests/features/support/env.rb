
#
# You shouldn't use like http://fixtures.landregistry.local as this will work locally
# but not in CI. So we need to use variables which can be over written.
# The commands below work as:
#   $URL_Variable_Name = (If_Not_Empty_Then_Use_This_Value ||(OR) This_Is_The_Default_Value )
#
# The ENV[] are defined as system variables, check the ./run_tests_preview.sh as an example how they are overridden
#

$CASEWORK_FRONTEND_DOMAIN =    (ENV['CASEWORK_FRONTEND_DOMAIN']    ||   'http://casework-frontend.landregistry.local')
$PROPERTY_FRONTEND_DOMAIN =    (ENV['PROPERTY_FRONTEND_DOMAIN']    ||   'http://property-frontend.landregistry.local')
$MINT_API_DOMAIN =             (ENV['MINT_API_DOMAIN']             ||   'http://mint.landregistry.local')
$SERVICE_FRONTEND_DOMAIN =     (ENV['SERVICE_FRONTEND_DOMAIN']     ||   'http://service-frontend.landregistry.local')
$LR_SEARCH_API_DOMAIN =        (ENV['LR_SEARCH_API_DOMAIN']        ||   'http://search-api.landregistry.local')
$SYSTEM_OF_RECORD_API_DOMAIN = (ENV['SYSTEM_OF_RECORD_API_DOMAIN'] ||   'http://system-of-record.landregistry.local')
$LR_FIXTURES_URL =             (ENV['LR_FIXTURES_URL']             ||   'http://fixtures.landregistry.local')
$INTRODUCTIONS_DOMAIN =        (ENV['INTRODUCTIONS_DOMAIN']        ||   'http://introductions.landregistry.local')
$CASES_URL =                   (ENV['CASES_URL']                   ||   'http://cases.landregistry.local')
$HISTORIAN_URL =               (ENV['HISTORIAN_URL']               ||   'http://historian.landregistry.local')
