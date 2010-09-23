require File.dirname(__FILE__) + '/../spec_helper'

describe <%= session_plural_class_name %>Controller do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

<%- if options[:authlogic] -%>
  it "create action should render new template when authentication is invalid" do
    post :create, :<%= session_singular_name %> => { :username => "foo", :password => "badpassword" }
    response.should render_template(:new)
    <%= session_class_name %>.find.should be_nil
  end

  it "create action should redirect when authentication is valid" do
    post :create, :<%= session_singular_name %> => { :username => "foo", :password => "secret" }
    response.should redirect_to("/")
    <%= session_class_name %>.find.<%= user_singular_name %>.should == <%= user_plural_name %>(:foo)
  end
<%- else -%>
  it "create action should render new template when authentication is invalid" do
    <%= user_class_name %>.stubs(:authenticate).returns(nil)
    post :create
    response.should render_template(:new)
    session['<%= user_singular_name %>_id'].should be_nil
  end

  it "create action should redirect when authentication is valid" do
    <%= user_class_name %>.stubs(:authenticate).returns(<%= user_class_name %>.first)
    post :create
    response.should redirect_to("/")
    session['<%= user_singular_name %>_id'].should == <%= user_class_name %>.first.id
  end
<%- end -%>
end
