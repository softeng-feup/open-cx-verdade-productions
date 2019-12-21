Feature: Signout

  Scenario: Should sign out
    Given I expect to be in "Agenda"
    When I signout
    Then I expect to be in "LoginRegisterPage"