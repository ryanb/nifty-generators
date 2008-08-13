  context "index action"
    should "render index template"
      get :index
      assert_template 'index'
    end
  end
