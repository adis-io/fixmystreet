Feature: Show location
    In order to see a problem place in detail
    As citizen of city
    I want to have access to problem place information

    Scenario: Show
        Given a reports:
          | title              | description             | latitude | longtitude |
          | Traffic            | asdfsfasasdfasdfasdfad  | 1        | 1          | 
          | Lyuk, ya tvoi otes | bla bla bla bla bla bla | 1        | 1          | 
        When I go to the home page
        And I follow "Traffic"
        Then I should see "Traffic"
        And I should see "asdfsfasasdfasdfasdfad"
