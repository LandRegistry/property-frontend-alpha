Feature: Citizen view full register of title

@service-frontend
Scenario: Full register of title

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS           |
    | restictive covenants      |
    | bankruptcy notice         |
    | easement                  |
    | provision                 |
    | price paid                |
    | restriction               |
    | charge                    |
    | other                     |
  When I view the full register of title
  Then I can see the following information displayed
    | INFORMATION                  |
    | Title Number                 |
    | Proprietors                  |
    | Structured Property Address  |
    | Price Paid                   |
    | Restrictive Covenants        |
    | Bankruptcy Notice            |
    | Easement                     |
    | Provision                    |
    | Restriction                  |
  And Audit for private citizen register view written

@service-frontend
Scenario: Proprietor can edit the register

  Given I am a citizen
  And I am the proprietor of a registered title
  When I view the full register of title
  Then I have the option to edit the register

@service-frontend
Scenario: Non proprietor cannot edit the register

  Given I am a citizen
  And a registered title
  When I view the full register of title
  Then I do not have the option to edit the register

@service-frontend
Scenario: Citizen can only view private register if logged in

  Given a registered title
  When I view the private register
  Then I am prompted to login as a private citizen

@service-frontend
Scenario: Private Register with Title Extents

  Given I am a citizen
  And a registered title with characteristics
    | CHARACTERISTICS                   |
    | has a polygon with easement       |
    | has a doughnut polygon            |
  When I view the full register of title
  And I check the title plan (private view)
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

@service-frontend
Scenario: Block user viewing X number of titles
  Given I am a citizen
  And I am unblocked
  And a registered title
  When I have viewed the private register 50 times
  Then I become blocked
