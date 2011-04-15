  it "edit action should render edit template" do
    get :edit, :id => <%= model_name %>.first
    response.should render_template(:edit)
  end
