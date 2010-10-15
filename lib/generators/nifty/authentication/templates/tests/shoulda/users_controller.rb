require 'test_helper'

class <%= user_plural_class_name %>ControllerTest < ActionController::TestCase
  context "new action" do
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end

  context "create action" do
    should "render new template when <%= user_singular_name %> is invalid" do
      <%= user_class_name %>.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end

    should "redirect when <%= user_singular_name %> is valid" do
      <%= user_class_name %>.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to "/"
    <%- unless options[:authlogic] -%>
      assert_equal assigns['<%= user_singular_name %>'].id, session['<%= user_singular_name %>_id']
    <%- end -%>
    end
  end

  context "edit action" do
    should "redirect when not logged in" do
      get :edit, :id => "ignored"
      assert_redirected_to login_url
    end

    should "render edit template" do
      @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
      get :edit, :id => "ignored"
      assert_template 'edit'
    end
  end

  context "update action" do
    should "redirect when not logged in" do
      put :update, :id => "ignored"
      assert_redirected_to login_url
    end

    should "render edit template when <%= user_singular_name %> is invalid" do
      @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
      <%= user_class_name %>.any_instance.stubs(:valid?).returns(false)
      put :update, :id => "ignored"
      assert_template 'edit'
    end

    should "redirect when <%= user_singular_name %> is valid" do
      @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
      <%= user_class_name %>.any_instance.stubs(:valid?).returns(true)
      put :update, :id => "ignored"
      assert_redirected_to "/"
    end
  end
end
