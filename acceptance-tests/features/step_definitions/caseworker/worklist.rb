When(/^I view the caseworker worklist$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}")
  step "I login to the casework frontend with correct credentials"
  click_link('Casework list')
end

When(/^I view the check worklist$/) do
  visit("#{$CASEWORK_FRONTEND_DOMAIN}")
  step "I login to the casework frontend with correct credentials"
  click_link('Check list')
end


Then(/^an option to approve the change of name request$/) do
  titleList = page.all(:xpath, ".//tr[td//text()[contains(.,'" + $regData['title_number'] + "')]]")
  assert_equal(titleList.length, 1, 'There are zero or more than one entries for title' + $regData['title_number'])
  assert_equal (titleList[0].has_button? 'complete'), true, 'Expected Complete button for change of name request'
end

When(/^I approve the change of name by way of marriage request$/) do
  titleList = page.all(:xpath, ".//tr[td//text()[contains(.,'" + $regData['title_number'] + "')]]")
  assert_equal(titleList.length, 1, 'There are zero or more than one entries for title' + $regData['title_number'])
  assert_equal (titleList[0].has_button? 'complete'), true, 'Expected Complete button for change of name request'
  titleList[0].find_button('complete').click
end
