require File.dirname(__FILE__) + '/../spec_helper'
 
describe <%= plural_class_name %>Controller do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => <%= class_name %>.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    <%= class_name %>.any_instance.stub(:valid? => false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect to index action when model is valid" do
    <%= class_name %>.any_instance.stub(:valid? => true)
    post :create
    response.should redirect_to(<%= singular_name %>_path(assigns[:<%= singular_name %>]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => <%= class_name %>.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    <%= class_name %>.any_instance.stub(:valid? => false)
    put :update, :id => <%= class_name %>.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect to show action when model is valid" do
    <%= class_name %>.any_instance.stub(:valid? => true)
    put :update, :id => <%= class_name %>.first
    response.should redirect_to(<%= singular_name %>_path(<%= class_name %>.first))
  end
  
  it "destroy action should destroy <%= singular_name %> and redirect to index action" do
    <%= singular_name %> = <%= class_name %>.first
    delete :destroy, :id => <%= singular_name %>
    response.should redirect_to(<%= plural_name %>_path)
    <%= class_name %>.exists?(<%= singular_name %>.id).should be_false
  end
end
