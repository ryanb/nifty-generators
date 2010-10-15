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
    assert_redirected_to "/"
  <%- unless options[:authlogic] -%>
    assert_equal assigns['<%= user_singular_name %>'].id, session['<%= user_singular_name %>_id']
  <%- end -%>
  end

  def test_edit_without_user
    get :edit, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_edit
    @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
    get :edit, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_without_user
    put :update, :id => "ignored"
    assert_redirected_to login_url
  end

  def test_update_invalid
    @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "ignored"
    assert_template 'edit'
  end

  def test_update_valid
    @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    assert_redirected_to "/"
  end
end
