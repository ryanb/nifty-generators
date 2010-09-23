require File.dirname(__FILE__) + '/../spec_helper'

describe <%= user_class_name %> do
<%- unless options[:authlogic] -%>
  def new_<%= user_singular_name %>(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    <%= user_class_name %>.new(attributes)
  end

  before(:each) do
    <%= user_class_name %>.delete_all
  end

  it "should be valid" do
    new_<%= user_singular_name %>.should be_valid
  end

  it "should require username" do
    new_<%= user_singular_name %>(:username => '').should have(1).error_on(:username)
  end

  it "should require password" do
    new_<%= user_singular_name %>(:password => '').should have(1).error_on(:password)
  end

  it "should require well formed email" do
    new_<%= user_singular_name %>(:email => 'foo@bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of email" do
    new_<%= user_singular_name %>(:email => 'bar@example.com').save!
    new_<%= user_singular_name %>(:email => 'bar@example.com').should have(1).error_on(:email)
  end

  it "should validate uniqueness of username" do
    new_<%= user_singular_name %>(:username => 'uniquename').save!
    new_<%= user_singular_name %>(:username => 'uniquename').should have(1).error_on(:username)
  end

  it "should not allow odd characters in username" do
    new_<%= user_singular_name %>(:username => 'odd ^&(@)').should have(1).error_on(:username)
  end

  it "should validate password is longer than 3 characters" do
    new_<%= user_singular_name %>(:password => 'bad').should have(1).error_on(:password)
  end

  it "should require matching password confirmation" do
    new_<%= user_singular_name %>(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
  end

  it "should generate password hash and salt on create" do
    <%= user_singular_name %> = new_<%= user_singular_name %>
    <%= user_singular_name %>.save!
    <%= user_singular_name %>.password_hash.should_not be_nil
    <%= user_singular_name %>.password_salt.should_not be_nil
  end

  it "should authenticate by username" do
    <%= user_singular_name %> = new_<%= user_singular_name %>(:username => 'foobar', :password => 'secret')
    <%= user_singular_name %>.save!
    <%= user_class_name %>.authenticate('foobar', 'secret').should == <%= user_singular_name %>
  end

  it "should authenticate by email" do
    <%= user_singular_name %> = new_<%= user_singular_name %>(:email => 'foo@bar.com', :password => 'secret')
    <%= user_singular_name %>.save!
    <%= user_class_name %>.authenticate('foo@bar.com', 'secret').should == <%= user_singular_name %>
  end

  it "should not authenticate bad username" do
    <%= user_class_name %>.authenticate('nonexisting', 'secret').should be_nil
  end

  it "should not authenticate bad password" do
    new_<%= user_singular_name %>(:username => 'foobar', :password => 'secret').save!
    <%= user_class_name %>.authenticate('foobar', 'badpassword').should be_nil
  end
<%- end -%>
end
