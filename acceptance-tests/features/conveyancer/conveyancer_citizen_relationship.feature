Feature: Create relationship between acting conveyancer and a citizen buyer(s) or seller(s)

@service-frontend
Scenario: Create relationship token for buyers
Given I have conveyancer login credentials
And I am not already logged in as a conveyancer
And clients have provided their details for me to act on their behalf
And a registered title
When I request to create a client relationship
And I login to the service frontend with correct credentials
And I select the property
And the clients want to buy the property
And I enter the clients details
And I confirm the details entered
Then a relationship token code is generated

@service-frontend
Scenario: Citizen authorises the conveyancer client relationship
Given I have private citizen login credentials
And I login to the service frontend with correct credentials
And I have a relationship token for a registered property
When I want to authorise my conveyancer to act on my behalf
And I enter the relationship token code
And I confirm the relationship
Then the relationship is confirmed

@service-frontend
Scenario: Citizen enters invalid relationship token
Given I have private citizen login credentials
And I am not already logged in as a private citizen
When I want to authorise my conveyancer to act on my behalf
And I enter an invalid relationship token code
Then message informing relationship token code is invalid is displayed
