Feature: Nifty Layout Generator
  In order to have a layout
  As a rails developer
  I want to generate a simple layout

  Background: Create a new rails app
    Given a new Rails 3.1.x app

  Scenario: Generate normal application layout
    When I run "rails g nifty:layout -f"
    Then I should see "stylesheet_link_tag "application"" in file "app/views/layouts/application.html.erb"
    Then I should see "h(page_title" in file "app/helpers/layout_helper.rb"
    And I should see the following files
      | app/helpers/layout_helper.rb            |
      | app/helpers/error_messages_helper.rb    |
      | app/assets/stylesheets/application.css  |

  Scenario Outline: Generate named layout with haml...
    When I run "rails g nifty:layout FooBar --<option> -f"
    Then I should see "stylesheet_link_tag "foo_bar" in file "app/views/layouts/foo_bar.html.haml"
    And I should see file "app/assets/stylesheets/foo_bar.<sass_version>"
    And I should see file "app/helpers/layout_helper.rb"

    Scenarios: ...and sass
      | option | sass_version |
      | haml   | sass         |

    Scenarios: ...and scss
      | option | sass_version |
      | scss   | css.scss     |
