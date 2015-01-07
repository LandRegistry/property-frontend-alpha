### Include Custom function libraries
require_relative '../../lib/dataCreation/general.rb'
require_relative '../../lib/dataCreation/polygon.rb'
require_relative '../../lib/dataCreation/register_creation2.rb'
require_relative '../../lib/dataCreation/conveyancer_client_token.rb'
require_relative '../../lib/dataCreation/change_of_name.rb'

require_relative '../../lib/webservice.rb'
require_relative '../../lib/log_checking.rb'
require_relative '../../lib/polygon_checking.rb'
require_relative '../../lib/data_formatting.rb'
require_relative '../../lib/validation/validate_worklist_fields.rb'
require_relative '../../lib/validation/validate_registered_title_fields.rb'
require_relative '../../lib/validation/validate_general.rb'

require 'net/https'
require 'digest/md5'
require 'capybara/cucumber'
require 'cucumber-performance'

### Allows you to use the page. commands
include Capybara::DSL

### Configures Capybara to use Xpath selectors and use poltergeist driver
Capybara.default_selector = :xpath
Capybara.default_wait_time = 10
Capybara.app_host = 'http://localhost:4567' # change url

if (ENV['WEBDRIVER'] == 'Firefox') then

  require 'selenium-webdriver'

  Capybara.default_driver = :selenium
  Capybara.javascript_driver = :selenium

else
  ### Includes Capybara (the visit, find, fill_in commands) and poltergeist (channel to phantomjs headless browser)
  require 'capybara/poltergeist'

  ### Configures Capybara to use Xpath selectors and use poltergeist driver
  Capybara.default_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist

  ### Set the options for poltergeist to use
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, :inspector => true, :js_errors => false)
  end
  #This removes the referer for the map tiles to be returned
  page.driver.add_header("Referer", "", permanent: true)

  require 'cucumber-performance-generator'

end

### Reads the basic auth username and password from env settings
$http_auth_name = (ENV['HTTPAUTH_USERNAME'] || '')
$http_auth_password = (ENV['HTTPAUTH_PASSWORD'] || '')
$logentries_key = (ENV['LOGENTRIES_KEY'] || '')
$ENVIRONMENT = (ENV['ENVIRONMENT'] || 'development')

### Includes the unit testing framework
require 'test/unit'
### Allows the functions (assert_equals to work)
include Test::Unit::Assertions
