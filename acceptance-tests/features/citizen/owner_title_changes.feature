Feature: Property owner view of pending & completed applications

@service-frontend
Scenario:As a property owner with pending and completed applications
Given I am a citizen
And I have private citizen login credentials
And I am the proprietor of a registered title
And completed applications exist
And pending applications exist
When I view the full register of title
And  I elect to view requests
Then a separate list of completed requests are shown in order of receipt by date & time
And a list of pending requests are shown in order of receipt by date & time

@service-frontend
Scenario:As a property owner with neither completed nor pending applications
Given I am a citizen
And I have private citizen login credentials
And I am the proprietor of a registered title
When I view the full register of title
And I elect to view requests
Then the no pending nor completed requests screen are displayed

@service-frontend
Scenario:As a property owner but not the proprietor of this title
Given I am a citizen
And I have private citizen login credentials
And a registered title
And pending applications exist
When I view the full register of title
Then a view requests option is not displayed
