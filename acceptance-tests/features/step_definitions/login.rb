Given(/^I am a citizen$/) do
  $userdetails = Hash.new()
  $userdetails['email'] = 'citizen@example.org'
  $userdetails['password'] = 'dummypassword'
  unblock_user($userdetails['email'])
end

Given(/^I am a user$/) do
  # A user isn't logged in, so don't do anything
end
