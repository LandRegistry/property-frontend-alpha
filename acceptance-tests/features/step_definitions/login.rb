Given(/^I have private citizen login credentials$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/auth/logout")

  $userdetails = Hash.new()
  $userdetails['email'] = 'citizen@example.org'
  $userdetails['password'] = 'dummypassword'
  unblock_user($userdetails['email'])
  set_user_view_count($userdetails['email'], 0)
end

Given(/^I have conveyancer login credentials$/) do
  $userdetails = Hash.new()
  $userdetails['email'] = 'conveyancer@example.org'
  $userdetails['password'] = 'dummypassword'
  unblock_user($userdetails['email'])
end

Given(/^I have caseworker login credentials$/) do
  $userdetails = Hash.new()
  $userdetails['email'] = 'caseworker@example.org'
  $userdetails['password'] = 'dummypassword'
end

When(/^I login to the service frontend with incorrect username$/) do
  fill_in('email', :with => 'incorrect')
  fill_in('password', :with => $userdetails['password'])
  click_button('Sign in')
end

When(/^I login to the casework frontend with incorrect username$/) do
  fill_in('email', :with => 'incorrect')
  fill_in('password', :with => $userdetails['password'])
  click_button('Login')
end

Then(/^I fail to login $/) do
  assert_match('Specified user does not exist', page.body, 'Expected error message informing the user was unsuccessful in logging in')
end

When(/^I login to the service frontend with incorrect password$/) do
  fill_in('email', :with => $userdetails['email'])
  fill_in('password', :with => 'incorrect')
  click_button('Sign in')
end

When(/^I login to the casework frontend with incorrect password$/) do
  fill_in('email', :with => $userdetails['email'])
  fill_in('password', :with => 'incorrect')
  click_button('Login')
end

Given(/^I login to the casework frontend with correct credentials$/) do
  fill_in('email', :with => $userdetails['email'])
  fill_in('password', :with => $userdetails['password'])
  click_button('Login')
end

Given(/^I login to the service frontend with correct credentials$/) do
  fill_in('email', :with => $userdetails['email'])
  fill_in('password', :with => $userdetails['password'])
  click_button('Sign in')
end

Then(/^I fail to login \(incorrect username\)$/) do
  assert_match('Specified user does not exist', page.body, 'Expected error message informing the user was unsuccessful in logging in')
end

Then(/^I fail to login \(incorrect password\)$/) do
  assert_match('Invalid password', page.body, 'Expected error message informing the user was unsuccessful in logging in')
end

Given(/^I am still authenticated$/) do
  # Logout first and re-login to ensure you're still logged in
  visit("#{$SERVICE_FRONTEND_DOMAIN}/auth/logout")
  step "I have private citizen login credentials"
  visit("#{$SERVICE_FRONTEND_DOMAIN}/auth/login")
  step "I login to the service frontend with incorrect username"
end

Given(/^I am not already logged in as a private citizen$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/auth/logout")
end

Given(/^I am not already logged in as a conveyancer$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/auth/logout")
end

When(/^I logout as a private citizen$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/auth/logout")
end

Then(/^I am prompted to login as a private citizen$/) do
  assert_match(/Login/i, page.body, 'Expected private citizen login page.')
end

Then(/^I fail to login$/) do
  assert_match('Sign in', page.body, 'Expected error message informing the user was unsuccessful in logging in')
end

When(/^I logout as a caseworker$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}/logout")
end

Then(/^I am prompted to login as a caseworker$/) do
  assert_match('Login', page.body, 'Expected caseworker login page.')
end

Given(/^I am not already logged in as a caseworker$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}")
end

Given(/^I am still authenticated as a caseworker$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}/logout")
  step "I have caseworker login credentials"
  visit("#{$CASEWORK_FRONTEND_DOMAIN}")
  step "I login to the casework frontend with correct credentials"
end

Then(/^I get an unauthorised message$/) do
  assert_match('Unauthorised', page.body, 'Expected to have an Unauthorized message')
end

Given(/^I am a citizen$/) do
  $userdetails = Hash.new()
  $userdetails['email'] = 'citizen@example.org'
  $userdetails['password'] = 'dummypassword'
  unblock_user($userdetails['email'])
end

Given(/^I am a user$/) do
  # A user isn't logged in, so don't do anything
end

Given(/^I am a caseworker$/) do
  $userdetails = Hash.new()
  $userdetails['email'] = 'caseworker@example.org'
  $userdetails['password'] = 'dummypassword'
end

Given(/^I have blocked private citizen login credentials$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/auth/logout")

  $userdetails = Hash.new()
  $userdetails['email'] = 'blocked@example.org'
  $userdetails['password'] = 'dummypassword'
end
