Feature: Logit with facebook
    In order to login and post or comment
    As a user 
    I want to be able to login with facebook or twitter

    Scenario: Login with facebook
        When I go to the homepage
        And I follow image "Login with Facebook"
        Then I should be on the homepage
        And I should see "Hello, Kalys Osmonov"
        And there should be a user:
          | email             | facebook_id | link                        | name          | gender | 
          | kalys@osmonov.com | 12345       | http://facebook.com/osmonov | Kalys Osmonov | Male   |

    Scenario: Login with twitter
        When I go to the homepage
        And I follow image "Login with Twitter"
        Then I should be on the homepage
        And I should see "Hello, Kalys Osmonov"
        And there should be a user:
          | twitter_id | link                            | name          | gender | 
          | 12345      | http://twitter.com/kalysosmonov | Kalys Osmonov | Male   |

    Scenario: Logout
        When I go to the homepage
        And I follow image "Login with Facebook"
        And I follow "Logout"
        Then I should be on the homepage
