Feature: Nifty Layout Generator
  In order to have a layout
  As a rails developer
  I want to generate a simple layout

  Scenario: Generate normal application layout
    Given a new Rails app
    When I run "rails g nifty:layout -f"
    Then I should see "stylesheet_link_tag "application"" in file "app/views/layouts/application.html.erb"
    Then I should see "h(page_title" in file "app/helpers/layout_helper.rb"
    And I should see file "app/helpers/layout_helper.rb"
    And I should see file "app/helpers/error_messages_helper.rb"
    And I should see file "public/stylesheets/application.css"

  Scenario: Generate named layout with haml and sass
    Given a new Rails app
    When I run "rails g nifty:layout FooBar --haml -f"
    Then I should see "stylesheet_link_tag "foo_bar"" in file "app/views/layouts/foo_bar.html.haml"
    And I should see file "public/stylesheets/sass/foo_bar.sass"
    And I should see file "app/helpers/layout_helper.rb"
