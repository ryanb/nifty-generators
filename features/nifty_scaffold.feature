Feature: Nifty Scaffold Generator
  In order to manage a resource
  As a rails developer
  I want to generate a model, controller, and views for that resource

  @focus
  Scenario: Generate scaffold for simple resource
    Given a new Rails app
    When I run "rails g nifty:scaffold Project name:string"
    Then I should see the following files
      | app/models/project.rb                  |
      | app/controllers/projects_controller.rb |
      | app/helpers/projects_helper.rb         |
      | app/views/projects/index.html.erb      |
      | app/views/projects/show.html.erb       |
      | app/views/projects/new.html.erb        |
      | app/views/projects/edit.html.erb       |
      | db/migrate                             |
    And I should see "resources :projects" in file "config/routes.rb"
    When I run "rails g nifty:layout -f"
    And I run "rake db:migrate"
    And I should successfully run "rails g nifty:scaffold Project -f"
    And I add "gem 'mocha', :group => :test" to file "Gemfile"
    Then I should successfully run "rake test"

  Scenario: Generate scaffold with rspec tests
    Given a new Rails app
    When I run "rails g nifty:scaffold Project name:string --rspec"
    Then I should see the following files
      | spec/models/project_spec.rb                  |
      | spec/controllers/projects_controller_spec.rb |
    And I should see "resources :projects" in file "config/routes.rb"
    When I run "rails g nifty:layout -f"
    And I run "rake db:migrate"
    And I add "gem 'mocha', :group => :test" to file "Gemfile"
    And I add "gem 'rspec-rails', '>= 2.0.0.beta.19'" to file "Gemfile"
    And I run "rails g rspec:install"
    Then I should successfully run "rake spec"
