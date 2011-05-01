Feature: Listing
    In order to be aware of problem places in my city
    As a citizen of city
    I want to see that problem places

    Background:
        Given a country "Kyrgyzstan"
        And cities "Bishkek, Osh, Karabalta" in "Kyrgyzstan"
        And I logged in

    Scenario: Listing
        Given a reports:
          | title                      | description             | latitude | longtitude | user              | city      |
          | Traffic light doesn't work | asdfsfasasdfasdfasdfad  | 1        | 1          | kalys@osmonov.com | Bishkek   |
          | Lyuk, ya tvoi otes         | bla bla bla bla bla bla | 1        | 1          | kalys@osmonov.com | Bishkek   |
          | Test test test             | bla bla bla bla bla bla | 1        | 1          | kalys@osmonov.com | Karabalta |

        When I go to the home page
        And I follow "Bishkek"
        Then I should see "Traffic light doesn't work" within "#report_list"
        And I should see "Lyuk, ya tvoi otes" within "#report_list"
        And I should not see "Test test test"
