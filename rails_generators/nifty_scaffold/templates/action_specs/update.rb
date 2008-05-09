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
