When(/^I view the private register$/) do
  #The URL is accessed directly with generated TN
  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}")
end

Given(/^I view the full register of title$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}")
  step "I login to the service frontend with correct credentials"
end

Given(/^I would like to change my name as I have been married$/) do
  click_button('Make a change to the register')
  find("//*[contains(text(),'" + $regData['proprietorship']['fields']['proprietors'][0]['name']['full_name'] + "')]/span[1]/a").click
end

Then(/^I do not have the option to edit the register$/) do
  assert_equal has_button?('Make a change to the register'), false, 'Expected Edit the register button to not be on the page'
end

Then(/^I have the option to edit the register$/) do
  assert_equal has_button?('Make a change to the register'), true, 'Expected Edit the register button to be on the page'
end

When(/^I have viewed the private register (\d+) times$/) do |views|
  set_user_view_count($userdetails['email'], views.to_i - 1)
  step "I view the private register"
  assert_match(/#{$regData['property_description']['fields']['addresses'][0]['postcode']}/i, page.body, 'Expected to see post code on the screen')
  step "I view the private register"
end
