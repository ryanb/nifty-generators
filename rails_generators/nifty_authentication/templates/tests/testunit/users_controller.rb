require 'test_helper'

class <%= user_plural_class_name %>ControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  <%- unless options[:authlogic] -%>
    assert_equal assigns['<%= user_singular_name %>'].id, session['<%= user_singular_name %>_id']
  <%- end -%>
  end
end
