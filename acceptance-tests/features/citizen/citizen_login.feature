Feature: Citizen login

@service-frontend
Scenario: Citizen Invalid username login failed

  Given I have private citizen login credentials
  When I login to the service frontend with incorrect username
  Then I fail to login

@service-frontend
Scenario: Citizen Invalid password login failed

  Given I have private citizen login credentials
  When I login to the service frontend with incorrect password
  Then I fail to login

@service-frontend
Scenario: Citizen can logout

  Given I have private citizen login credentials
  And I am still authenticated
  When I logout as a private citizen
  Then I am prompted to login as a private citizen

@service-frontend
Scenario: Blocked Citizen login failed

  Given I have blocked private citizen login credentials
  When I login to the service frontend with incorrect password
  Then I fail to login
