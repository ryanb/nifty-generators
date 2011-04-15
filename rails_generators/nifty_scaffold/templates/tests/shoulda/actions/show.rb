  context "show action" do
    should "render show template" do
      get :show, :id => <%= model_name %>.first
      assert_template 'show'
    end
  end
