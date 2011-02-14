Feature: Nifty Authentication Generator
  In order to authenticate users
  As a rails developer
  I want to generate some user authentication

  Scenario: Generate default authentication
    Given a new Rails app
    When I insert "root :to => 'users#new'" into "config/routes.rb" after line 1
    And I run "rails g nifty:authentication"
    Then I should see the following files
      | app/models/user.rb                          |
      | app/controllers/users_controller.rb         |
      | app/helpers/users_helper.rb                 |
      | app/views/users/new.html.erb                |
      | app/views/users/edit.html.erb               |
      | app/controllers/sessions_controller.rb      |
      | app/helpers/sessions_helper.rb              |
      | app/views/sessions/new.html.erb             |
      | lib/controller_authentication.rb            |
      | test/fixtures/users.yml                     |
      | test/unit/user_test.rb                      |
      | test/functional/users_controller_test.rb    |
      | test/functional/sessions_controller_test.rb |
      | db/migrate                                  |
    And I should see the following in file "config/routes.rb"
      | resources :sessions                                          |
      | resources :users                                             |
      | match 'login' => 'sessions#new', :as => :login               |
      | match 'logout' => 'sessions#destroy', :as => :logout         |
      | match 'signup' => 'users#new', :as => :signup                |
      | match 'user/edit' => 'users#edit', :as => :edit_current_user |
    And I should see "include ControllerAuthentication" in file "app/controllers/application_controller.rb"
    And I should see "gem "mocha", :group => :test" in file "Gemfile"
    And I should see "gem "bcrypt-ruby", :require => "bcrypt"" in file "Gemfile"
    When I run "rails g nifty:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

  Scenario: Generate named authentication
    Given a new Rails app
    When I insert "root :to => 'accounts#new'" into "config/routes.rb" after line 1
    And I run "rails g nifty:authentication Account CurrentSession"
    Then I should see the following files
      | app/models/account.rb                               |
      | app/controllers/accounts_controller.rb              |
      | app/helpers/accounts_helper.rb                      |
      | app/views/accounts/new.html.erb                     |
      | app/views/accounts/edit.html.erb                    |
      | app/controllers/current_sessions_controller.rb      |
      | app/helpers/current_sessions_helper.rb              |
      | app/views/current_sessions/new.html.erb             |
      | test/fixtures/accounts.yml                          |
      | test/unit/account_test.rb                           |
      | test/functional/accounts_controller_test.rb         |
      | test/functional/current_sessions_controller_test.rb |
    And I should see the following in file "config/routes.rb"
      | resources :current_sessions                                   |
      | resources :accounts                                           |
      | match 'login' => 'current_sessions#new', :as => :login        |
      | match 'logout' => 'current_sessions#destroy', :as => :logout  |
      | match 'signup' => 'accounts#new', :as => :signup              |
      | match 'account/edit' => 'accounts#edit', :as => :edit_current_account |
    When I run "rails g nifty:layout -f"
    And I run "rake db:migrate"
    Then I should successfully run "rake test"

  Scenario: Generate named authentication with rspec
    Given a new Rails app
    When I insert "root :to => 'accounts#new'" into "config/routes.rb" after line 1
    And I run "rails g nifty:authentication Account CurrentSession --rspec"
    Then I should see the following files
      | spec/models/account_spec.rb                          |
      | spec/controllers/accounts_controller_spec.rb         |
      | spec/controllers/current_sessions_controller_spec.rb |
    When I run "rails g nifty:layout -f"
    And I run "rake db:migrate"
    And I add "gem 'rspec-rails', '>= 2.0.1'" to file "Gemfile"
    And I run "rails g rspec:install"
    And I replace "mock_with :rspec" with "mock_with :mocha" in file "spec/spec_helper.rb"
    Then I should successfully run "rake spec"
