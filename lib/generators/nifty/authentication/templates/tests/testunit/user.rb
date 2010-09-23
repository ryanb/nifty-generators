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

  def test_valid
    assert new_<%= user_singular_name %>.valid?
  end

  def test_require_username
    assert new_<%= user_singular_name %>(:username => '').errors[:username]
  end

  def test_require_password
    assert new_<%= user_singular_name %>(:password => '').errors[:password]
  end

  def test_require_well_formed_email
    assert new_<%= user_singular_name %>(:email => 'foo@bar@example.com').errors[:email]
  end

  def test_validate_uniqueness_of_email
    new_<%= user_singular_name %>(:email => 'bar@example.com').save!
    assert new_<%= user_singular_name %>(:email => 'bar@example.com').errors[:email]
  end

  def test_validate_uniqueness_of_username
    new_<%= user_singular_name %>(:username => 'uniquename').save!
    assert new_<%= user_singular_name %>(:username => 'uniquename').errors[:username]
  end

  def test_validate_odd_characters_in_username
    assert new_<%= user_singular_name %>(:username => 'odd ^&(@)').errors[:username]
  end

  def test_validate_password_length
    assert new_<%= user_singular_name %>(:password => 'bad').errors[:password]
  end

  def test_require_matching_password_confirmation
    assert new_<%= user_singular_name %>(:password_confirmation => 'nonmatching').errors[:password]
  end

  def test_generate_password_hash_and_salt_on_create
    <%= user_singular_name %> = new_<%= user_singular_name %>
    <%= user_singular_name %>.save!
    assert <%= user_singular_name %>.password_hash
    assert <%= user_singular_name %>.password_salt
  end

  def test_authenticate_by_username
    <%= user_class_name %>.delete_all
    <%= user_singular_name %> = new_<%= user_singular_name %>(:username => 'foobar', :password => 'secret')
    <%= user_singular_name %>.save!
    assert_equal <%= user_singular_name %>, <%= user_class_name %>.authenticate('foobar', 'secret')
  end

  def test_authenticate_by_email
    <%= user_class_name %>.delete_all
    <%= user_singular_name %> = new_<%= user_singular_name %>(:email => 'foo@bar.com', :password => 'secret')
    <%= user_singular_name %>.save!
    assert_equal <%= user_singular_name %>, <%= user_class_name %>.authenticate('foo@bar.com', 'secret')
  end

  def test_authenticate_bad_username
    assert_nil <%= user_class_name %>.authenticate('nonexisting', 'secret')
  end

  def test_authenticate_bad_password
    <%= user_class_name %>.delete_all
    new_<%= user_singular_name %>(:username => 'foobar', :password => 'secret').save!
    assert_nil <%= user_class_name %>.authenticate('foobar', 'badpassword')
  end
<%- end -%>
end
