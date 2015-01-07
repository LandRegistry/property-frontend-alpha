Then(/^the Property Address is displayed$/) do
  assert_match(/#{$regData['property']['address']['address_line_1']}/i, page.body, 'Expected to find address line 1')
  assert_match(/#{$regData['property']['address']['address_line_2'].gsub(')', '\)').gsub('(', '\(')}/i, page.body, 'Expected to find address line 2')
  assert_match(/#{$regData['property']['address']['city']}/i, page.body, 'Expected to find city')
  assert_match(/#{$regData['property']['address']['postcode']}/i, page.body, 'Expected to find postcode')
end

Then(/^Title Number is displayed$/) do
  assert_match(/#{$regData['title_number']}/i, page.body, 'Expected to see title number')
end

Then(/^Price Paid is displayed$/) do
  assert_match(/#{$regData['payment']['price_paid'].to_s.reverse.gsub(/...(?=.)/,'\&,').reverse}/i, page.body, 'Expected to see price paid')
end

When(/^I try to view a property that does not exist$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/property/XXXXXXXXX")
end

Then(/^an error is displayed$/) do
  assert_match('Page not found', page.body, 'Expected not to find the page')
end

Then(/^No lease information is displayed$/) do
  assert_no_selector(".//*[@id='leaseDate']")
  assert_no_selector(".//*[@id='leaseTerm']")
  assert_no_selector(".//*[@id='parties']")
end

Then(/^Date of Lease is displayed$/) do
  lease_date_formatted = Date.parse($regData['leases'][0]['lease_date'])
  lease_date_formatted = lease_date_formatted.strftime("%d %B %Y")
  assert_selector(".//*[@id='leaseDate']", text: lease_date_formatted)
end

Then(/^Lease Term is displayed$/) do
  assert_selector(".//*[@id='leaseTerm']", text: /#{$regData['leases'][0]['lease_term']} years/)
end

Then(/^Lease Term start date is displayed$/) do
  lease_term_start_date_formatted = Date.parse($regData['leases'][0]['lease_from'])
  lease_term_start_date_formatted = lease_term_start_date_formatted.strftime("%d %B %Y")
  assert_selector(".//*[@id='leaseTerm']", text: /from #{lease_term_start_date_formatted}/)
end

Then(/^Lessor name is displayed$/) do
  assert_selector(".//*[@id='parties']", text: /1. #{$regData['leases'][0]['lessor_name']}/)
end

Then(/^Lessee name is displayed$/) do
  assert_selector(".//*[@id='parties']", text: /2. #{$regData['leases'][0]['lessee_name']}/)
end

Then(/^Lessee name is not displayed$/) do
  assert_no_selector(".//*[@id='parties']", text: /2. #{$regData['leases'][0]['lessee_name']}/)
end

Then(/^the lease clauses are not displayed$/) do
  assert_no_selector(".//*[@id='easementClause']")
  assert_no_selector(".//*[@id='easementClause']")
  assert_no_selector(".//*[@id='alienationClause']")
end

Then(/^the lease clauses are displayed$/) do
  assert_selector(".//*[@id='easementClause']")
  assert_selector(".//*[@id='easementClause']")
  assert_selector(".//*[@id='alienationClause']")
end

Then(/^the property details page is displayed$/) do
  assert_match('Property details', page.body, 'Expected Property Details page')
end

Then(/^I have the option to view the full register$/) do
  assert_equal has_link?('View register'), true, 'Expected View full register button to be on the page'
end

When(/^I view the property details on gov\.uk$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/property/#{$regData['title_number']}")
end
