require File.dirname(__FILE__) + '/../spec_helper'
 
describe <%= sessions_class_name %>Controller do
  fixtures :all
  integrate_views
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when authentication is invalid" do
    <%= user_class_name %>.stubs(:authenticate).returns(nil)
    post :create
    response.should render_template(:new)
    session['<%= user_singular_name %>_id'].should be_nil
  end
  
  it "create action should redirect when authentication is valid" do
    <%= user_class_name %>.stubs(:authenticate).returns(<%= user_class_name %>.first)
    post :create
    response.should redirect_to(root_url)
    session['<%= user_singular_name %>_id'].should == <%= user_class_name %>.first.id
  end
end
