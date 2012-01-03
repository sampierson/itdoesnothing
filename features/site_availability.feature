Feature: Site Availability Control
  As an admin
  I want to be able to control access to the site during maintenance periods

  Background:
    Given there exists a user with email "fred@example.com" and password "secret"
    And that user "fred@example.com" is confirmed

  Scenario: When site availability is "fully operational" logged in users do not get logged out
    Given I sign in as "fred@example.com" with password "secret"
    And site availability is set to "fully operational"
    When I go to the home page
    Then I should be signed in

  Scenario: When site availability is "fully operational" new users may sign up    
    Given site availability is set to "fully operational"
    When I attempt to sign up as "bert@example.com" with password "secret"
    Then I should see "You have signed up successfully"

  Scenario: When site availability is "fully operational" users may sign in    
    Given site availability is set to "fully operational"
    When I attempt to sign in as "fred@example.com" with password "secret"
    Then I should see "Signed in successfully"
    And I should be signed in

  Scenario: When site availability is "prevent new signups" logged in users do not get logged out
    Given I sign in as "fred@example.com" with password "secret"
    And site availability is set to "prevent new signups"
    When I go to the home page
    Then I should be signed in

  Scenario: When site availability is "prevent new signups" new users MAY NOT sign up    
    Given site availability is set to "prevent new signups"
    When I go to the home page
    And I follow "Sign up"
    Then I should see "new users may not sign-up at this time"

  Scenario: When site availability is "prevent new signups" users may sign in    
    Given site availability is set to "prevent new signups"
    When I attempt to sign in as "fred@example.com" with password "secret"
    Then I should see "Signed in successfully"

  Scenario: When site availability is "prevent user logins" logged in users do not get logged out
    Given I sign in as "fred@example.com" with password "secret"
    And site availability is set to "prevent user logins"
    When I go to the home page
    Then I should be signed in

  Scenario: When site availability is "prevent user logins" new users MAY NOT sign up    
    Given site availability is set to "prevent user logins"
    When I go to the home page
    And I follow "Sign up"
    Then I should see "new users may not sign-up at this time"

  Scenario: When site availability is "prevent user logins" users MAY NOT sign in    
    Given site availability is set to "prevent user logins"
    When I go to the new user session page
    When I attempt to sign in as "fred@example.com" with password "secret"
    Then I should see "site is currently undergoing maintenance"

  Scenario: When site availability is "admins only" logged in users GET LOGGED OUT
    Given I sign in as "fred@example.com" with password "secret"
    And site availability is set to "admins only"
    When I go to the home page
    Then I should see "site is currently undergoing maintenance"
    And I should be signed out

  Scenario: When site availability is "admins only" new users MAY NOT sign up    
    Given site availability is set to "admins only"
    When I go to the home page
    And I follow "Sign up"
    Then I should see "new users may not sign-up at this time"

  Scenario: When site availability is "admins only" users MAY NOT sign in    
    Given site availability is set to "admins only"
    When I attempt to sign in as "fred@example.com" with password "secret"
    Then I should see "site is currently undergoing maintenance"
    
  Scenario: When site availability is "admins only" admin users sign in
    Given site availability is set to "admins only"
    And there exists a user with email "admin@cureus.com" and password "secret"
    And that user "admin@cureus.com" is confirmed
    And that user "admin@cureus.com" has role "admin"
    When I attempt to sign in as "admin@cureus.com" with password "secret"
    Then I should see "admin@cureus.com"
