Feature: Listing
    In order to be aware of problem places in my city
    As a citizen of city
    I want to see that problem places

    Background:
        Given I logged in

    Scenario: Listing
        Given a reports:
          | title                      | description             | latitude | longtitude | user              |
          | Traffic light doesn't work | asdfsfasasdfasdfasdfad  | 1        | 1          | kalys@osmonov.com |
          | Lyuk, ya tvoi otes         | bla bla bla bla bla bla | 1        | 1          | kalys@osmonov.com | 

        When I go to the home page
        Then I should see "Traffic light doesn't work" within "#report_list"
        Then I should see "Lyuk, ya tvoi otes" within "#report_list"
