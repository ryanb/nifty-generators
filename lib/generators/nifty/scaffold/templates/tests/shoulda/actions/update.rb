  context "update action" do
    should "render edit template when model is invalid" do
      <%= class_name %>.any_instance.stubs(:valid?).returns(false)
      put :update, :id => <%= class_name %>.first
      assert_template 'edit'
    end
  
    should "redirect when model is valid" do
      <%= class_name %>.any_instance.stubs(:valid?).returns(true)
      put :update, :id => <%= class_name %>.first
      assert_redirected_to <%= item_path_for_test('url') %>
    end
  end
