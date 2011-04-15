  it "show action should render show template" do
    get :show, :id => <%= model_name %>.first
    response.should render_template(:show)
  end
