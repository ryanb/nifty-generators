  def test_create_invalid
    <%= class_name %>.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    <%= class_name %>.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to <%= item_path_for_test('url') %>
  end
