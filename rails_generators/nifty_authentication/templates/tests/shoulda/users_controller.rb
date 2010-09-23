require 'test_helper'

class <%= user_plural_class_name %>ControllerTest < ActionController::TestCase
  context "new action" do
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end

  context "create action" do
    should "render new template when model is invalid" do
      <%= user_class_name %>.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end

    should "redirect when model is valid" do
      <%= user_class_name %>.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to root_url
    <%- unless options[:authlogic] -%>
      assert_equal assigns['<%= user_singular_name %>'].id, session['<%= user_singular_name %>_id']
    <%- end -%>
    end
  end
end
