Feature: Find a property on gov.uk and view its details

@property-frontend
Scenario: A user can find a property and view its details

  Given I am a user
  And a registered title
  When I search for the property on gov.uk
  Then I can see the following information displayed
    | INFORMATION      |
    | Title Number     |
    | Property Address |
  And I have the option to view the property details

  When I choose to view the property details
  Then I can see the following information displayed
    | INFORMATION      |
    | Title Number     |
    | Property Address |
    | Tenure           |

@property-frontend
Scenario: A user cannot find a property that does not exist

  Given I am a user
  When I search for a property on gov.uk that does not exist
  Then I get a no results are found message
