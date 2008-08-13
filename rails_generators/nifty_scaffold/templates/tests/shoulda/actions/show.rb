  context "show action"
    should "render show template"
      get :show, :id => <%= class_name %>.first
      assert_template 'show'
    end
  end
