When(/^I search for the property on gov\.uk$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/search")
  fill_in('search', :with => $regData['title_number'])
  main = page.all(:xpath, ".//main")
  main[0].find_button('Search').click
end

Given(/^I search for a property on gov\.uk that does not exist$/) do
  visit("#{$PROPERTY_FRONTEND_DOMAIN}/search")
  fill_in('search', :with => 'xx')
  main = page.all(:xpath, ".//main")
  main[0].find_button('Search').click
end

Then(/^I get a no results are found message$/) do
  assert_match('Sorry, no results have been found.', page.body, 'Expected an error message saying no results found, however this wasn\'t present')
end

Then(/^I have the option to view the property details$/) do
  address_split = $regData['property_description']['fields']['addresses'][0]['full_address'].split(',')
  assert_equal has_link?(address_split[0]), true, 'Expected View register link'
end

When(/^I choose to view the property details$/) do
  address_split = $regData['property_description']['fields']['addresses'][0]['full_address'].split(',')
  click_link(address_split[0])
end

def getSearchResultForTitleNumber()
  arr = Array.new
  page.all(:xpath, ".//ul[@class='results-list']").each do |row|
    if (row.text.include? $regData['title_number'])
      arr << row
    end
  end
  assert_equal(arr.length, 1, "There are #{arr.length} search results for" + $regData['title_number'])
  return arr[0]
end
