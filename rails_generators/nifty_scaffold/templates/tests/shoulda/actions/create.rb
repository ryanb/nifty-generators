  context "create action"
    should "render new template when model is invalid"
      <%= class_name %>.any_instance.stubs(:valid?).returns(false)
      post :create
      assert_template 'new'
    end
    
    should "redirect when model is valid"
      <%= class_name %>.any_instance.stubs(:valid?).returns(true)
      post :create
      assert_redirected_to <%= item_path_for_test('url') %>
    end
  end
