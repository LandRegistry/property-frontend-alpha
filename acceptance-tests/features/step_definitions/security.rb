Given(/^I am unblocked$/) do
  unblock_user($userdetails['email'])
  set_user_view_count($userdetails['email'], 0)
end

Then(/^I become blocked$/) do
  assert_match('Sign in', page.body, 'blocked error expected')
end
