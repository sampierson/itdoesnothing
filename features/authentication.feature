Feature: Authentication

  Background:
    Given there exists a user with email "fred@example.com" and password "foobar"

  Scenario: Create a new account
    Given that there does not exist a user with email "bert@example.com"
    And I go to the home page
    And I follow "Sign up"
    And I fill in "Email" with "bert@example.com"
    And I fill in "Password" with "berts_password"
    And I fill in "Password confirmation" with "berts_password"
    And I press "Sign up"
    Then I should be on the home page
    And I should see "You have signed up successfully"

  Scenario: Confirm new account
    Given that user "fred@example.com" is not confirmed
    And I go to the confirmation link for user "fred@example.com"
    Then I should be on the root page
    And I should see "Your account was successfully confirmed"
    And I should see "fred@example.com"
    And I should see "Sign out"

  Scenario: Sign in and out
    Given that user "fred@example.com" is confirmed
    When I go to the home page
    And I follow "Sign in"
    And I fill in "Email" with "fred@example.com"
    And I fill in "Password" with "foobar"
    And I press "Sign in"
    Then I should see "Signed in successfully"
    And I should see "Signed in as fred@example.com"

    Given I follow "Sign out"
    Then I should not see "Signed in as fred@example.com"
    And I should see "Sign in"

  Scenario: Recover password
    Given that user "fred@example.com" is confirmed
    And I go to the new user session page
    When I follow "Forgot your password?"
    Given I fill in "Email" with "fred@example.com"
    And I press "Send me reset password instructions"
    Then I should see "You will receive an email with instructions about how to reset your password"

  Scenario: Re-request confirmation instructions
    Given that user "fred@example.com" is not confirmed
    And I go to the new user session page
    And I follow "Didn't receive confirmation instructions?"
    Given I fill in "Email" with "fred@example.com"
    And I press "Resend confirmation instructions"
    Then I should see "You will receive an email with instructions about how to confirm your account"

  Scenario: Account gets locked
    Given that user "fred@example.com" is confirmed
    And that user "fred@example.com" has attempted to login 19 times
    When I go to the new user session page
    And I fill in "Email" with "fred@example.com"
    And I fill in "Password" with "the wrong password"
    And I press "Sign in"
    Then I should see "Invalid email or password."

    When I fill in "Email" with "fred@example.com"
    And I fill in "Password" with "the wrong password"
    And I press "Sign in"
    Then I should see "Your account is locked"

  Scenario: Request unlock instructions
    Given that user "fred@example.com" is confirmed
    And that user "fred@example.com" is locked
    When I go to the new user session page
    And I follow "Didn't receive unlock instructions?"
    And I fill in "Email" with "fred@example.com"
    And I press "Resend unlock instructions"
    Then I should see "You will receive an email with instructions about how to unlock your account"

  Scenario: Unlock account
    Given that user "fred@example.com" is confirmed
    And that user "fred@example.com" is locked
    When I go to the unlock link for user "fred@example.com"
    Then I should see "Your account was successfully unlocked"
    And I should see "fred@example.com"
    And I should see "Sign out"