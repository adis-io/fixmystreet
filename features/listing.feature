Feature: Listing
    In order to be aware of problem places in my city
    As a citizen of city
    I want to see that problem places

    Scenario: Listing
        Given a reports:
          | title                      | description             | latitude | longtitude |
          | Traffic light doesn't work | asdfsfasasdfasdfasdfad  | 1        | 1          | 
          | Lyuk, ya tvoi otes         | bla bla bla bla bla bla | 1        | 1          | 

        When I go to the home page
        Then I should see "Traffic light doesn't work" within "#report_list"
        Then I should see "Lyuk, ya tvoi otes" within "#report_list"
