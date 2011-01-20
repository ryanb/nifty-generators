require 'test_helper'

class <%= session_plural_class_name %>ControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

<%- if options[:authlogic] -%>
  def test_create_invalid
    post :create, :<%= session_singular_name %> => { :username => "foo", :password => "badpassword" }
    assert_template 'new'
    assert_nil <%= session_class_name %>.find
  end

  def test_create_valid
    post :create, :<%= session_singular_name %> => { :username => "foo", :password => "secret" }
    assert_redirected_to root_url
    assert_equal <%= user_plural_name %>(:foo), <%= session_class_name %>.find.<%= user_singular_name %>
  end
<%- else -%>
  def test_create_invalid
    <%= user_class_name %>.stubs(:authenticate).returns(nil)
    post :create
    assert_template 'new'
    assert_nil session['<%= user_singular_name %>_id']
  end

  def test_create_valid
    <%= user_class_name %>.stubs(:authenticate).returns(<%= user_class_name %>.first)
    post :create
    assert_redirected_to root_url
    assert_equal <%= user_class_name %>.first.id, session['<%= user_singular_name %>_id']
  end
<%- end -%>
end
