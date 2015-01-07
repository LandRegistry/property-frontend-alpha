Feature: Change proprietor name by way of marriage

@service-frontend
Scenario: Proprietor can change name on title after they have been married

  Given I am a citizen
  And I am the proprietor of a registered title
  And I view the full register of title
  And I would like to change my name as I have been married
  When I provide details of my change of name by marriage
  Then the details of my change of name by marriage request are reflected back to me in a statement

  When I confirm the statement reflecting my change of name by marriage is accurate and submit it
  Then I receive an acknowledgement my request has been sent to Land Registry
  And my change of name by marriage request is now with Land Registry

@service-frontend
Scenario: Proprietor must confirm change of name before submitting change of name by way of marriage details

  Given I am a citizen
  And I am the proprietor of a registered title
  And I view the full register of title
  And I would like to change my name as I have been married
  When I provide details of my change of name by marriage
  Then the details of my change of name by marriage request are reflected back to me in a statement
  When I do not confirm the statement reflecting my change of name by marriage is accurate and submit it
  Then the details of my change of name by marriage request are reflected back to me in a statement

@service-frontend
Scenario: Registered users who are not the proprietor of a property cannot request to change a proprietor name

  Given I am a citizen
  And a registered title
  When I try to make a change of name by marriage request for the title
  Then I get an unauthorised message
