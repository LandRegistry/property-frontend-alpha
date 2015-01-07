Given(/^a change of name by marriage application that requires reviewing by a caseworker$/) do
  step "a registered title with characteristics", ''
  $marriage_data = create_marriage_data('GB', $regData['proprietorship']['fields']['proprietors'][0]['name']['full_name'], $regData['title_number'])
  create_change_of_name_marriage_request($marriage_data)
  wait_for_case_to_exist($regData['title_number'])
end

Given(/^a change of name by marriage application that requires checking$/) do
  step "a registered title with characteristics", ''
  $marriage_data = create_marriage_data('AU', $regData['proprietorship']['fields']['proprietors'][0]['name']['full_name'], $regData['title_number'])
  create_change_of_name_marriage_request($marriage_data)
  wait_for_case_to_exist($regData['title_number'])
end

When(/^I provide details of my change of name by marriage$/) do
  validateChangeNameMarriageForm()

  $marriage_data = create_marriage_data('United Kingdom', $regData['proprietorship']['fields']['proprietors'][0]['name']['full_name'], $regData['title_number'])

  fill_in('proprietor_new_full_name', :with => $marriage_data['proprietor_new_full_name'])
  fill_in('partner_name', :with => $marriage_data['partner_name'])
  fill_in('marriage_date', :with => $marriage_data['marriage_date'])
  fill_in('marriage_place', :with => $marriage_data['marriage_place'])
  select($marriage_data['marriage_country'], :from => "marriage_country")
  fill_in('marriage_certificate_number', :with => $marriage_data['marriage_certificate_number'])
  click_button('Submit')
end

Then(/^the details of my change of name by marriage request are reflected back to me in a statement$/) do
  dateOfMarriage = Date.strptime($marriage_data['marriage_date'], "%d-%m-%Y")
  formattedDate = dateOfMarriage.strftime("%-d %B %Y").to_s

  text1 = "I confirm that I, #{$marriage_data['proprietor_new_full_name']}, was married to #{$marriage_data['partner_name']} on #{formattedDate} in #{$marriage_data['marriage_place']}, #{$marriage_data['marriage_country']}."
  assert_match(text1, page.body, 'Expected to see confirmation message with marriage details')

  text2 = "The information I provide in this application will be used to change the name on registered title number #{$regData['title_number']}."
  assert_match(text2, page.body, 'Expected to see message with title number')

  assert_match('Confirm', page.body, 'Expected to certify statement including personnal details')
end

When(/^I confirm the statement reflecting my change of name by marriage is accurate and submit it$/) do
    check('confirm')
    click_button('Submit')
end

Then(/^I receive an acknowledgement my request has been sent to Land Registry$/) do
  assert_match('Application complete', page.body, 'Expected Application complete')
end

When(/^I do not confirm the statement reflecting my change of name by marriage is accurate and submit it$/) do
  click_button('Submit')
end

When(/^I try to make a change of name by marriage request for the title$/) do
  visit("#{$SERVICE_FRONTEND_DOMAIN}/property/#{$regData['title_number']}/edit/title.proprietor.1")
  step "I login to the service frontend with correct credentials"
end

Then(/^my change of name by marriage request is now with Land Registry$/) do
  wait_for_case_to_exist($regData['title_number'])
end


def validateChangeNameMarriageForm()
  click_button('Submit')
  validateField('error_proprietor_new_full_name', 'This field is required.')
  validateField('error_partner_name', 'This field is required.')
  validateField('error_marriage_date', 'This field is required.')
  validateField('error_marriage_place', 'This field is required.')
  validateField('error_marriage_certificate_number', 'This field is required.')
end
