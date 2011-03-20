Feature: Logit with facebook
    In order to login and post or comment
    As a user 
    I want to be able to login with facebook or twitter

    Scenario: Login with facebook
        When I go to the homepage
        And I follow "Login with Facebook"
        Then I should be on the homepage
        And I should see "Welcome, Kalys Osmonov"

    Scenario: Login with twitter
        When I go to the homepage
        And I follow "Login with Twitter"
        Then I should be on the homepage
        And I should see "Welcome, Kalys Osmonov"

    Scenario: Logout
        When I go to the homepage
        And I follow "Login with Facebook"
        And I follow "Logout"
        Then I should be on the homepage
