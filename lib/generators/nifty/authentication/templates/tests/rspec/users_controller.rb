require File.dirname(__FILE__) + '/../spec_helper'

describe <%= user_plural_class_name %>Controller do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(root_url)
  <%- unless options[:authlogic] -%>
    session['<%= user_singular_name %>_id'].should == assigns['<%= user_singular_name %>'].id
  <%- end -%>
  end

  it "edit action should redirect when not logged in" do
    get :edit, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "edit action should render edit template" do
    @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
    get :edit, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when not logged in" do
    put :update, :id => "ignored"
    response.should redirect_to(login_url)
  end

  it "update action should render edit template when <%= user_singular_name %> is invalid" do
    @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(false)
    put :update, :id => "ignored"
    response.should render_template(:edit)
  end

  it "update action should redirect when <%= user_singular_name %> is valid" do
    @controller.stubs(:current_<%= user_singular_name %>).returns(<%= user_class_name %>.first)
    <%= user_class_name %>.any_instance.stubs(:valid?).returns(true)
    put :update, :id => "ignored"
    response.should redirect_to(root_url)
  end
end
