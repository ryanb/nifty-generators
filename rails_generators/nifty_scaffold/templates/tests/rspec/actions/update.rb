  it "update action should render edit template when model is invalid" do
    <%= model_name %>.any_instance.stubs(:valid?).returns(false)
    put :update, :id => <%= model_name %>.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    <%= model_name %>.any_instance.stubs(:valid?).returns(true)
    put :update, :id => <%= model_name %>.first
    response.should redirect_to(<%= item_path_for_spec('url') %>)
  end
