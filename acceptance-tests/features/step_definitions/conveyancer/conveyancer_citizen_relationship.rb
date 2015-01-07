When(/^I select the property$/) do
  click_link('Start now')
  fill_in('search', :with => $regData['title_number'])
  click_button('Search')
  click_button('Select this property')
end

When(/^the clients want to buy the property$/) do
  choose('Buying')
  click_button('Next')
end

When(/^I request to create a client relationship$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/relationship/conveyancer")
end

Given(/^clients have provided their details for me to act on their behalf$/) do
  $relationshipData = generate_client_details()
end

When(/^I enter the clients details$/) do
  fill_in('full_name', :with => $relationshipData['clients']['full_name'])
  fill_in('date_of_birth', :with => $relationshipData['clients']['date_of_birth'])
  fill_in('address', :with => $relationshipData['clients']['address'])
  fill_in('telephone', :with => $relationshipData['clients']['telephone'])
  fill_in('email', :with => $relationshipData['clients']['email'])
  choose($relationshipData['clients']['gender'])
  click_button('Add client')
end

When(/^I confirm the details entered$/) do
  click_link('Confirm details')
end

Then(/^a relationship token code is generated$/) do
  created_token = find(".//*[@class='title-flag']").text
  validate_token_format(created_token)
end

Given(/^I want to authorise my conveyancer to act on my behalf$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}")
  step "I login to the service frontend with correct credentials"
  click_link('Confirm a relationship')
end

Given(/^I have a relationship token for a registered property$/) do
  step "a registered title"

  $relationship_details = generate_relationship_details($regData['title_number'])
  $token_code = $relationship_details['token']
end

When(/^I enter the relationship token code$/) do
  click_link('Start now')
  fill_in('token', :with => $token_code)
  click_button('Submit')
end

When(/^I enter an invalid relationship token code$/) do
  click_link('Start now')
  fill_in('token', :with => "Rubbish")
  click_button('Submit')
end

Then(/^message informing relationship token code is invalid is displayed$/) do
  assert_match(/Page not found/i, page.body, 'Expected to get invalid error message')
end

When(/^I confirm the relationship$/) do
    check('check-1')
    click_button('Confirm relationship')
end

Then(/^the relationship is confirmed$/) do

  assert_match(/You've verified your relationship/i, page.body, 'Expected to get message saying the relationship was confirmed')
end
