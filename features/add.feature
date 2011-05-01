Feature: Add Report
    In order to warn about problem place
    As citizen of city
    I want to add problem place information

    Background:
        Given a country "Kyrgyzstan"
        And cities "Bishkek, Osh, Karabalta" in "Kyrgyzstan"

    Scenario: Add
        Given I logged in
        When I go to the homepage
        And I follow "Bishkek"
        And I follow "Submit new report"
        And I fill in "Title" with "Report Place"
        And I fill in "Description" with "adfhasdfhasdhfashfashfasjdfhak"
        And I fill in "Link to video" with "http://blive.kg/video:46620/"
        And I attach the file "/Users/kalysosmonov/projects/fixmystreet/spec/fixtures/aoeu.jpg" to "report[photo1]"
        And I attach the file "/Users/kalysosmonov/projects/fixmystreet/spec/fixtures/aoeu.jpg" to "report[photo2]"
        And I attach the file "/Users/kalysosmonov/projects/fixmystreet/spec/fixtures/aoeu.jpg" to "report[photo3]"
        And I attach the file "/Users/kalysosmonov/projects/fixmystreet/spec/fixtures/aoeu.jpg" to "report[photo4]"
        And I attach the file "/Users/kalysosmonov/projects/fixmystreet/spec/fixtures/aoeu.jpg" to "report[photo5]"
        And I press "Save"
        Then there should be reports:
          | title        | description                    |
          | Report Place | adfhasdfhasdhfashfashfasjdfhak |
        And I should be on the "Report Place" report page
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
