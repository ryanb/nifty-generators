  def test_update_invalid
    <%= class_name %>.any_instance.stubs(:valid?).returns(false)
    put :update, :id => <%= class_name %>.first
    assert_template 'edit'
  end
  
  def test_update_valid
    <%= class_name %>.any_instance.stubs(:valid?).returns(true)
    put :update, :id => <%= class_name %>.first
    assert_redirected_to <%= item_path_for_test('url') %>
  end
