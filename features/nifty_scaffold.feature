Feature: Nifty Scaffold Generator
  In order to manage a resource
  As a rails developer
  I want to generate a model, controller, and views for that resource
  
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
    When I run "rails g nifty:layout"
    And I run "rake db:migrate"
    And I add "gem 'mocha', :group => :test" to file "Gemfile"
    Then I should successfully run "rake test"
