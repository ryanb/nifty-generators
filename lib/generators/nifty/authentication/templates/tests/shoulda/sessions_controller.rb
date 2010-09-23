require 'test_helper'

class <%= session_plural_class_name %>ControllerTest < ActionController::TestCase
  context "new action" do
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end

  context "create action" do
  <%- if options[:authlogic] -%>
    should "render new template when authentication is invalid" do
      post :create, :<%= session_singular_name %> => { :username => "foo", :password => "badpassword" }
      assert_template 'new'
      assert_nil <%= session_class_name %>.find
    end

    should "redirect when authentication is valid" do
      post :create, :<%= session_singular_name %> => { :username => "foo", :password => "secret" }
      assert_redirected_to "/"
      assert_equal <%= user_plural_name %>(:foo), <%= session_class_name %>.find.<%= user_singular_name %>
    end
  <%- else -%>
    should "render new template when authentication is invalid" do
      <%= user_class_name %>.stubs(:authenticate).returns(nil)
      post :create
      assert_template 'new'
      assert_nil session['<%= user_singular_name %>_id']
    end

    should "redirect when authentication is valid" do
      <%= user_class_name %>.stubs(:authenticate).returns(<%= user_class_name %>.first)
      post :create
      assert_redirected_to "/"
      assert_equal <%= user_class_name %>.first.id, session['<%= user_singular_name %>_id']
    end
  <%- end -%>
  end
end
