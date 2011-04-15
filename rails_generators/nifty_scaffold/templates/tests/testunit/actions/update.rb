  def test_update_invalid
    <%= model_name %>.any_instance.stubs(:valid?).returns(false)
    put :update, :id => <%= model_name %>.first
    assert_template 'edit'
  end

  def test_update_valid
    <%= model_name %>.any_instance.stubs(:valid?).returns(true)
    put :update, :id => <%= model_name %>.first
    assert_redirected_to <%= item_path_for_test('url') %>
  end
