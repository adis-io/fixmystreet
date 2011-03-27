Feature: Show location
    In order to see a problem place in detail
    As citizen of city
    I want to have access to problem place information

    Background:
        Given I logged in

    Scenario: Show
        Given a reports:
          | title              | description             | latitude | longtitude |  user              |
          | Traffic            | asdfsfasasdfasdfasdfad  | 1        | 1          |  kalys@osmonov.com |
          | Lyuk, ya tvoi otes | bla bla bla bla bla bla | 1        | 1          |  kalys@osmonov.com |
        When I go to the home page
        And I follow "Traffic"
        Then I should see "Traffic"
        And I should see "asdfsfasasdfasdfasdfad"
        And I should see "Kalys Osmonov"
