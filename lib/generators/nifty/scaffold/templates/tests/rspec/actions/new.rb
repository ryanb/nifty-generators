  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
