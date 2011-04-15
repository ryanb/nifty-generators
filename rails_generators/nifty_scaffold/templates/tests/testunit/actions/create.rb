  def test_create_invalid
    <%= model_name %>.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    <%= model_name %>.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to <%= item_path_for_test('url') %>
  end
