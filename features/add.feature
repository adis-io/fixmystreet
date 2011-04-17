Feature: Add Report
    In order to warn about problem place
    As citizen of city
    I want to add problem place information

    Scenario: Add
        Given I logged in
        When I go to the homepage
        And I follow "Submit new report"
        And I fill in "Title" with "Report Place"
        And I fill in "Description" with "adfhasdfhasdhfashfashfasjdfhak"
        And I press "Save"
        Then I should be on the "Report Place" report page
        And I should see "Report Place" 
        And I should see "adfhasdfhasdhfashfashfasjdfhak"


    Scenario: Add without title
        Given I logged in
        When I go to the home page
        And I follow "Submit new report"
        And I fill in "Description" with "adfhasdfhasdhfashfashfasjdfhak"
        And I press "Save"
        Then the "Description" field should contain "adfhasdfhasdhfashfashfasjdfhak"

    Scenario: Add unauthentificated
        When I go to the home page
        And I follow "Submit new report"
        And I follow "Login with Facebook"
        And I fill in "Title" with "Report Place"
        And I fill in "Description" with "adfhasdfhasdhfashfashfasjdfhak"
        And I press "Save"
        Then I should be on the "Report Place" report page
        And I should see "Report Place" 
        And I should see "adfhasdfhasdhfashfashfasjdfhak"
