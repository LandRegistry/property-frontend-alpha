Feature: Caseworker login

@casework-frontend
Scenario: Caseworker Invalid username login failed
Given I have caseworker login credentials
And I am not already logged in as a caseworker
And I login to the casework frontend with incorrect username
Then I fail to login (incorrect username)

@casework-frontend
Scenario: Caseworker Invalid password login failed
Given I have caseworker login credentials
And I am not already logged in as a caseworker
When I login to the casework frontend with incorrect password
Then I fail to login (incorrect password)

@casework-frontend
Scenario: Caseworker can logout
Given I have caseworker login credentials
And I am still authenticated as a caseworker
When I logout as a caseworker
Then I am prompted to login as a caseworker
