  context "new action"
    should "render new template"
      get :new
      assert_template 'new'
    end
  end
