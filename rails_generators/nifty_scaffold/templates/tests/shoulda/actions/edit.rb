  context "edit action" do
    should "render edit template" do
      get :edit, :id => <%= model_name %>.first
      assert_template 'edit'
    end
  end
