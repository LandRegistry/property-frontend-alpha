Given(/^historical versions of the register exist$/) do
  #change loop to have as many historical records as you want
  for i in 0..2 do
    $historical_data = create_historical_data($regData)
    post_to_historical($historical_data, $regData['title_number'])
  end
end

Then(/^the correct historical versions of the register are displayed$/) do
  title_version_history = get_all_historical_titles($regData['title_number'])
  result = find(:xpath, "//ol[@class='register-changes-previous']")
  puts result.native.text
  for i in 0..title_version_history.length-1 do
    assert_match(title_version_history[i]["contents"]["edition_date"], result.native.text, 'Expected to find edition date '+ title_version_history[i]["contents"]["edition_date"] +' displayed on the screen')
  end

  for i in 0..title_version_history.length-1 do
    visit("#{$SERVICE_FRONTEND_DOMAIN}/property/" + $regData['title_number'] +"/changes")
    click_link('Version '+(i+1).to_s)
  end
end
