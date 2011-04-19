Feature: Update report
    In order to make changes to report
    As a citizen of my city
    I want to be able to update my reports

    Scenario: Update report as owner
      Given I logged in
      And a reports:
        | title              | description             | latitude | longtitude |  user              |
        | Traffic            | asdfsfasasdfasdfasdfad  | 1        | 1          |  kalys@osmonov.com |
      When I go to the home page
      And I follow "Traffic"
      And I follow "Edit"
      And I fill in "Title" with "Traffic light"
      And I fill in "Description" with "Test test test test test"
      And I press "Save"
      Then I should be on the "Traffic light" report page
      And I should see "Traffic light"
      And I should see "Test test test test test"

    Scenario: Try to update others report
      Given I logged in
      And a user "test@fixmystreet.kg"
      And a reports:
        | title              | description             | latitude | longtitude | user                |
        | Traffic            | asdfsfasasdfasdfasdfad  | 1        | 1          | test@fixmystreet.kg |
      When I go to the home page
      And I follow "Traffic"
      Then I should not see "Edit"
      When I go to the "Traffic" report edit page
      Then I should be on the home page
      


    Scenario: Update as moderator
      Given I logged in
      And a user "test@fixmystreet.kg"
      And a user "kalys@osmonov.com" with role "Moderator"
      And a reports:
        | title              | description             | latitude | longtitude | user                |
        | Traffic            | asdfsfasasdfasdfasdfad  | 1        | 1          | test@fixmystreet.kg |
      When I go to the home page
      And I follow "Traffic"
      And I follow "Edit"
      And I fill in "Title" with "Traffic light"
      And I fill in "Description" with "Test test test test test"
      And I press "Save"
      Then I should be on the "Traffic light" report page
      And I should see "Traffic light"
      And I should see "Test test test test test"

    Scenario: Update as admin
      Given I logged in
      And a user "test@fixmystreet.kg"
      And a user "kalys@osmonov.com" with role "Admin"
      And a reports:
        | title              | description             | latitude | longtitude | user                |
        | Traffic            | asdfsfasasdfasdfasdfad  | 1        | 1          | test@fixmystreet.kg |
      When I go to the home page
      And I follow "Traffic"
      And I follow "Edit"
      And I fill in "Title" with "Traffic light"
      And I fill in "Description" with "Test test test test test"
      And I press "Save"
      Then I should be on the "Traffic light" report page
      And I should see "Traffic light"
      And I should see "Test test test test test"
