require 'test_helper'

class <%= user_class_name %>Test < ActiveSupport::TestCase
<%- unless options[:authlogic] -%>
  def new_<%= user_singular_name %>(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    <%= user_singular_name %> = <%= user_class_name %>.new(attributes)
    <%= user_singular_name %>.valid? # run validations
    <%= user_singular_name %>
  end

  def setup
    <%= user_class_name %>.delete_all
  end

  should "be valid" do
    assert new_<%= user_singular_name %>.valid?
  end

  should "require username" do
    assert_equal ["can't be blank"], new_<%= user_singular_name %>(:username => '').errors[:username]
  end

  should "require password" do
    assert_equal ["can't be blank"], new_<%= user_singular_name %>(:password => '').errors[:password]
  end

  should "require well formed email" do
    assert_equal ["is invalid"], new_<%= user_singular_name %>(:email => 'foo@bar@example.com').errors[:email]
  end

  should "validate uniqueness of email" do
    new_<%= user_singular_name %>(:email => 'bar@example.com').save!
    assert_equal ["has already been taken"], new_<%= user_singular_name %>(:email => 'bar@example.com').errors[:email]
  end

  should "validate uniqueness of username" do
    new_<%= user_singular_name %>(:username => 'uniquename').save!
    assert_equal ["has already been taken"], new_<%= user_singular_name %>(:username => 'uniquename').errors[:username]
  end

  should "not allow odd characters in username" do
    assert_equal ["should only contain letters, numbers, or .-_@"], new_<%= user_singular_name %>(:username => 'odd ^&(@)').errors[:username]
  end

  should "validate password is longer than 3 characters" do
    assert_equal ["is too short (minimum is 4 characters)"], new_<%= user_singular_name %>(:password => 'bad').errors[:password]
  end

  should "require matching password confirmation" do
    assert_equal ["doesn't match confirmation"], new_<%= user_singular_name %>(:password_confirmation => 'nonmatching').errors[:password]
  end

  should "generate password hash on create" do
    <%= user_singular_name %> = new_<%= user_singular_name %>
    <%= user_singular_name %>.save!
    assert <%= user_singular_name %>.password_hash
  end

  should "authenticate by username" do
    <%= user_singular_name %> = new_<%= user_singular_name %>(:username => 'foobar', :password => 'secret')
    <%= user_singular_name %>.save!
    assert_equal <%= user_singular_name %>, <%= user_class_name %>.authenticate('foobar', 'secret')
  end

  should "authenticate by email" do
    <%= user_singular_name %> = new_<%= user_singular_name %>(:email => 'foo@bar.com', :password => 'secret')
    <%= user_singular_name %>.save!
    assert_equal <%= user_singular_name %>, <%= user_class_name %>.authenticate('foo@bar.com', 'secret')
  end

  should "not authenticate bad username" do
    assert_nil <%= user_class_name %>.authenticate('nonexisting', 'secret')
  end

  should "not authenticate bad password" do
    new_<%= user_singular_name %>(:username => 'foobar', :password => 'secret').save!
    assert_nil <%= user_class_name %>.authenticate('foobar', 'badpassword')
  end
<%- end -%>
end
