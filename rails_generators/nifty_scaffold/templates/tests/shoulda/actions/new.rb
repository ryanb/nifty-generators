  context "new action" do
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end
