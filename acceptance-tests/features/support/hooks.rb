Before do | scenario |

  # Lets Create the default users if they don't already exist
  rest_get_call($LR_FIXTURES_URL + '/setup_default_users');

  # This chunk of code manages different authentication types.
  if page.driver.respond_to?(:basic_auth)
    page.driver.basic_auth($http_auth_name, $http_auth_password)
  elsif page.driver.respond_to?(:basic_authorize)
    page.driver.basic_authorize($http_auth_name, $http_auth_password)
  elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
    page.driver.browser.basic_authorize($http_auth_name, $http_auth_password)
  end

  # The start time of the test running
  $log_start_time = (Time.now.to_f * 1000).to_i

  # If running using poltergeist it's useful to blank out the referrer,
  # this is needed for the mapping tests
  if (ENV['WEBDRIVER'] != 'Firefox') then
    page.driver.add_header("Referer", "", permanent: true)
  end
end

After do | scenario |
  # If the scenario failed let's take a screenshot. It helps for debugging
  if (scenario.failed?)
      save_screenshot("sshot-#{Time.new.to_i}.png", :full => true)
  end
end
