  context "edit action" do
    should "render edit template" do
      get :edit, :id => <%= class_name %>.first
      assert_template 'edit'
    end
  end
