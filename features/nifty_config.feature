Feature: Nifty Config Generator
  In order to have configure an app
  As a rails developer
  I want to generate a config file and manager

  Scenario: Generate normal config
    Given a new Rails app
    When I run "rails g nifty:config"
    Then I should see file "config/app_config.yml"
    And I should see file "config/initializers/load_app_config.rb"

  Scenario: Generate named config
    Given a new Rails app
    When I run "rails g nifty:config FooBar"
    Then I should see "FOO_BAR_CONFIG" in file "config/initializers/load_foo_bar_config.rb"
    And I should see "config/foo_bar_config.yml" in file "config/initializers/load_foo_bar_config.rb"
    And I should see file "config/foo_bar_config.yml"

  Scenario: Retrieve data from config
    Given a new Rails app
    When I run "rails g nifty:config FooBar"
    And the following text is put into the file "config/foo_bar_config.yml"
      """
      all:
        one: One

      development:
        two: Two
        three: Three

      test:
        one: 1
      """
    Then the constant FOO_BAR_CONFIG should contain the following data when in the development environment:
      | Key   | Value |
      | one   | One   |
      | two   | Two   |
      | three | Three |
    And the constant FOO_BAR_CONFIG should contain the following data when in the test environment:
      | Key   | Value |
      | one   | 1     |
