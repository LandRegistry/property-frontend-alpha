Given(/^a registered title with characteristics$/) do |table|
  $regData = create_base_register(table)
end

Given(/^a registered title$/) do
  step "a registered title with characteristics", ''
end

Given(/^I am the proprietor of a registered title$/) do
  step "a registered title with characteristics", ''
  link_title_to_email($userdetails['email'], $regData['title_number'], 'CITIZEN')
end

Then(/^the register of title is updated with the new name$/) do
  wait_for_register_to_update_full_name($regData['title_number'], $marriage_data['proprietor_new_full_name'])
end
