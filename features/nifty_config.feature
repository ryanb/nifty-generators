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
