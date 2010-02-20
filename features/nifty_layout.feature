Feature: Nifty Layout Generator
  In order to have a layout
  As a rails developer
  I want to generate a simple layout

  Scenario: Generate normal application layout
    Given a new Rails app
    When I run "rails g nifty:layout"
    Then I should see file "app/views/layouts/application.html.erb"
    And I should see file "app/helpers/layout_helper.rb"
