Feature: Login to the application
  As a team member
  I want to login to the application
  So that I can operate the application

  Scenario: Login to the application
    Given I want to login
    When I click the login button
    Then I should see "Projexion" as the title