Feature: View property details on gov.uk

@property-frontend
Scenario: Citizen View public register

  Given I am a citizen
  And a registered title with characteristics
  | CHARACTERISTICS           |
  | restictive covenants      |
  | bankruptcy notice         |
  | easement                  |
  | provision                 |
  | price paid                |
  | restriction               |
  When I view the property details on gov.uk
  Then I can see the following information displayed
    | INFORMATION      |
    | Title Number     |
    | Property Address |
    | Price Paid       |
  And I have the option to view the full register

@property-frontend
Scenario: try to view register that does not exist

  Given I am a citizen
  When I try to view a property that does not exist
  Then an error is displayed

@property-frontend
Scenario: Public Register with Title Extents

  Given I am a citizen
  And a registered title with characteristics
      | CHARACTERISTICS                   |
      | has a polygon with easement       |
      | has a doughnut polygon            |
  When I view the property details on gov.uk
  And I check the title plan (public view)
  Then I can see the following information displayed
    | INFORMATION                   |
    | multiple polygons             |
    | whole polygin is in view      |
    | the polygons match the title  |
    | the polygons are edged in red |
    | there is a donut polygon      |
    | there is a normal polygon     |
    | the map can't be zoomed       |
    | the map can't be moved        |
    | the polygons are over a map   |
