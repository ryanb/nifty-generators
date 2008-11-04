require 'test_helper'

class <%= user_class_name %>Test < ActiveSupport::TestCase
  def new_<%= user_singular_name %>(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    <%= user_singular_name %> = <%= user_class_name %>.new(attributes)
    <%= user_singular_name %>.valid? # run validations
    <%= user_singular_name %>
  end
  
  should "be valid" do
    assert new_<%= user_singular_name %>.valid?
  end
  
  should "require username" do
    assert new_<%= user_singular_name %>(:username => '').errors.on(:username)
  end
  
  should "require password" do
    assert new_<%= user_singular_name %>(:password => '').errors.on(:password)
  end
  
  should "require well formed email" do
    assert new_<%= user_singular_name %>(:email => 'foo@bar@example.com').errors.on(:email)
  end
  
  should "require matching password confirmation" do
    assert new_<%= user_singular_name %>(:password_confirmation => 'nonmatching').errors.on(:password)
  end
  
  should "generate password hash and salt on create" do
    <%= user_singular_name %> = new_<%= user_singular_name %>
    <%= user_singular_name %>.save!
    assert <%= user_singular_name %>.password_hash
    assert <%= user_singular_name %>.password_salt
  end
  
  should "authenticate by username" do
    <%= user_class_name %>.delete_all
    <%= user_singular_name %> = new_<%= user_singular_name %>(:username => 'foobar', :password => 'secret')
    <%= user_singular_name %>.save!
    assert_equal <%= user_singular_name %>, <%= user_class_name %>.authenticate('foobar', 'secret')
  end
  
  should "authenticate by email" do
    <%= user_class_name %>.delete_all
    <%= user_singular_name %> = new_<%= user_singular_name %>(:email => 'foo@bar.com', :password => 'secret')
    <%= user_singular_name %>.save!
    assert_equal <%= user_singular_name %>, <%= user_class_name %>.authenticate('foo@bar.com', 'secret')
  end
  
  should "not authenticate bad username" do
    assert_nil <%= user_class_name %>.authenticate('nonexisting', 'secret')
  end
  
  should "not authenticate bad password" do
    <%= user_class_name %>.delete_all
    new_<%= user_singular_name %>(:username => 'foobar', :password => 'secret').save!
    assert_nil <%= user_class_name %>.authenticate('foobar', 'badpassword')
  end
end
