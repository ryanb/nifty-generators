Feature: Nifty Authentication Generator
  In order to authenticate users
  As a rails developer
  I want to generate some user authentication
  
  Scenario: Generate default authentication
    Given a new Rails app
    When I run "rails g nifty:authentication"
    Then I should see the following files
      | app/models/user.rb                          |
      | app/controllers/users_controller.rb         |
      | app/helpers/users_helper.rb                 |
      | app/views/users/new.html.erb                |
      | app/controllers/sessions_controller.rb      |
      | app/helpers/sessions_helper.rb              |
      | app/views/sessions/new.html.erb             |
      | lib/authentication.rb                       |
      | test/fixtures/users.yml                     |
      | test/unit/user_test.rb                      |
      | test/functional/users_controller_test.rb    |
      | test/functional/sessions_controller_test.rb |
      | db/migrate                                  |
    And I should see the following in file "config/routes.rb"
      | resources :sessions                                  |
      | resources :users                                     |
      | match 'login' => 'sessions#new', :as => :login       |
      | match 'logout' => 'sessions#destroy', :as => :logout |
      | match 'signup' => 'users#new', :as => :signup        |
    And I should see "include Authentication" in file "app/controllers/application_controller.rb"
    When I run "rails g nifty:layout"
    And I run "rake db:migrate"
    And I add "gem 'mocha', :group => :test" to file "Gemfile"
    Then I should successfully run "rake test"
  
  Scenario: Generate named authentication
    Given a new Rails app
    When I run "rails g nifty:authentication Account CurrentSession"
    Then I should see the following files
      | app/models/account.rb                               |
      | app/controllers/accounts_controller.rb              |
      | app/helpers/accounts_helper.rb                      |
      | app/views/accounts/new.html.erb                     |
      | app/controllers/current_sessions_controller.rb      |
      | app/helpers/current_sessions_helper.rb              |
      | app/views/current_sessions/new.html.erb             |
      | test/fixtures/accounts.yml                          |
      | test/unit/account_test.rb                           |
      | test/functional/accounts_controller_test.rb         |
      | test/functional/current_sessions_controller_test.rb |
    And I should see the following in file "config/routes.rb"
      | resources :current_sessions                                  |
      | resources :accounts                                          |
      | match 'login' => 'current_sessions#new', :as => :login       |
      | match 'logout' => 'current_sessions#destroy', :as => :logout |
      | match 'signup' => 'accounts#new', :as => :signup             |
    When I run "rails g nifty:layout"
    And I run "rake db:migrate"
    And I add "gem 'mocha', :group => :test" to file "Gemfile"
    Then I should successfully run "rake test"
