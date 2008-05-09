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
