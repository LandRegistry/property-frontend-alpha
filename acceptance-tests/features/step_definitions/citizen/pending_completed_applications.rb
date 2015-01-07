Given(/^pending applications exist$/) do

  $pending_cases = []

  for i in 0..2 do

    $marriage_data = create_marriage_data('GB', $regData['proprietorship']['fields']['proprietors'][0]['name']['full_name'], $regData['title_number'])
    $pending_cases << create_change_of_name_marriage_request($marriage_data)
    $pending_cases[i]['regdata'] = $regData
    $pending_cases[i]['marriage_data'] = $marriage_data

  end

end

Given(/^completed applications exist$/) do

  $completed_cases = []

  name = $regData['proprietorship']['fields']['proprietors'][0]['name']['full_name']

  for i in 0..2 do

    $regData = get_register_details($regData['title_number'])
    $marriage_data = create_marriage_data('GB', name, $regData['title_number'])
    $completed_cases << create_change_of_name_marriage_request($marriage_data)
    $completed_cases[i]['regdata'] = $regData
    $completed_cases[i]['marriage_data'] = $marriage_data
    complete_case($completed_cases[i]['case_id'])
    wait_for_register_to_update_full_name($regData['title_number'], $marriage_data['proprietor_new_full_name'])

    name = $completed_cases[i]['marriage_data']['proprietor_new_full_name']

  end



end

When(/^I elect to view requests$/) do
    find(".//h3[contains(., 'Changes to this title')]").click
    click_link('View pending and historical changes to this title')
end

Then(/^a list of pending requests are shown in order of receipt by date & time$/) do
  requests = page.all(".//ol[@class='register-changes-pending']/*")
  list = []
  requests.each do |row|
    list.push(row)
  end

  cases = get_cases_by_title_number_and_status($pending_cases[0]["title_number"], 'queued')

  assert_equal list.length, $pending_cases.length, "number of pending changes does not match what is expected"

  list.each_with_index do |row, idx|
    submitted_on_text = "SUBMITTED ON " + getDateTimeFormatted(cases[idx]['submitted_at']).upcase
    submitted_by_text = "Submitted by " + cases[idx]['submitted_by']
    assert row.text.include?(submitted_on_text), "The requests were not in the correct order"
    assert row.text.include?(submitted_by_text), "The submitted by was incorrect"
  end
end

Then(/^a separate list of completed requests are shown in order of receipt by date & time$/) do
  requests = page.all(".//ol[@class='register-changes-previous']/*")
  list = []
  requests.each do |row|
    list.push(row)
  end

  assert_equal list.length, $completed_cases.length, "number of versions does not match what is expected"

  list.reverse.each_with_index do |row, idx|
    assert row.text.include?("Version " + (idx + 1).to_s), "The version was not in the correct order"
    link_text = 'View register on ' + getDateTimeFormatted($completed_cases[idx]['regdata']['last_application'])
    assert_equal has_link?(link_text), true, 'Expected link to view version ' + (idx + 1).to_s
  end
end

Then(/^a view requests option is not displayed$/) do
    assert_equal has_link?('View pending and historical changes to this title'), false, 'Expected View pending and historical changes to this title link to not be on the page'
end

Then(/^an error message re unauthorised is displayed$/) do
  assert_match('Unauthorised', page.body, 'Expected to find Unauthorised text displayed on the screen')
end

Then(/^the no pending nor completed requests screen are displayed$/) do
  assert_match('There are no pending changes to this title register', page.body, 'Expected to find No pending changes text displayed on the screen')
  assert_match('There have been no changes to this title register', page.body, 'Expected to find No previous changes text displayed on the screen')
end

def getDateTimeFormatted(date)
  date_time = DateTime.parse(date)
  formatted_time = date_time.strftime('%H:%M:%S')
  formatted_date = date_time.strftime('%e %B %Y')
  return formatted_date.strip + ' at ' + formatted_time
end
