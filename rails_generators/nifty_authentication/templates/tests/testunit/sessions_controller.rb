require 'test_helper'

class <%= sessions_class_name %>ControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
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
end
