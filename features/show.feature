Feature: Show location
    In order to see a problem place in detail
    As citizen of city
    I want to have access to problem place information

    Background:
        Given a country "Kyrgyzstan"
        And cities "Bishkek, Osh, Karabalta" in "Kyrgyzstan"
        And I logged in

    Scenario: Show
        Given a reports:
          | title              | description             | latitude | longtitude |  user              | city      |
          | Traffic            | asdfsfasasdfasdfasdfad  | 1        | 1          |  kalys@osmonov.com | Bishkek   |
          | Lyuk, ya tvoi otes | bla bla bla bla bla bla | 1        | 1          |  kalys@osmonov.com | Karabalta |
        When I go to the home page
        And I follow "Bishkek"
        And I follow "Traffic"
        Then I should see "Traffic"
        And I should see "asdfsfasasdfasdfasdfad"
        And I should see "Kalys Osmonov"
