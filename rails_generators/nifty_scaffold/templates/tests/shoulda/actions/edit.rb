  context "edit action"
    should "render edit template"
      get :edit, :id => <%= class_name %>.first
      assert_template 'edit'
    end
  end
