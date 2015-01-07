#Audit for service frontend (when citizen logs in to view)
Then(/^Audit for private citizen register view written$/) do
  url = "https://pull.logentries.com/#{$logentries_key}/hosts/ManualHostService/lr-service-frontend/"

  check_logs_for_message(url, getlrid("citizen@example.org"))
  check_logs_for_message(url, $regData['title_number'])
end
