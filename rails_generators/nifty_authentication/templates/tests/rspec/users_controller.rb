require File.dirname(__FILE__) + '/../spec_helper'

describe <%= user_plural_class_name %>Controller do
  fixtures :all
  integrate_views

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
end
