Feature: Add Report
    In order to warn about problem place
    As citizen of city
    I want to add problem place information

    Scenario: Add
        When I go to the homepage
        And I follow "Add Report"
        And I fill in "Title" with "Report Place"
        And I fill in "Description" with "adfhasdfhasdhfashfashfasjdfhak"
        And I press "Save"
        Then I should be on the "Report Place" report page
        And I should see "Report Place" 
        And I should see "adfhasdfhasdhfashfashfasjdfhak"


    Scenario: Add without title
        When I go to the home page
        And I follow "Add Report"
        And I fill in "Description" with "adfhasdfhasdhfashfashfasjdfhak"
        And I press "Save"
        Then the "Description" field should contain "adfhasdfhasdhfashfashfasjdfhak"
