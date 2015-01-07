Feature: Caseworker worklist

@casework-frontend
Scenario: View Change of Name in work queue (no Checking)

  Given I am a caseworker
  And a change of name by marriage application that requires reviewing by a caseworker
  When I view the caseworker worklist
  Then I can see the following information displayed
     | INFORMATION                              |
     | Marriage Details                         |
     | Title Number In Worklist                 |
     | Date Request Was Submitted               |
     | Application Type Of Change Name Marriage |
  And an option to approve the change of name request

@casework-frontend
Scenario: View Change of Name in work queue (Checking)

  Given I am a caseworker
  And a change of name by marriage application that requires checking
  When I view the check worklist
  Then I can see the following information displayed
     | INFORMATION                              |
     | Title Number In Worklist                 |
     | Date Request Was Submitted               |
     | Application Type Of Change Name Marriage |

@casework-frontend
Scenario: Caseworker can process a change of name by way of marriage request and update the title of register

  Given I am a caseworker
  And a change of name by marriage application that requires reviewing by a caseworker
  And I view the caseworker worklist
  When I approve the change of name by way of marriage request
  Then the register of title is updated with the new name
