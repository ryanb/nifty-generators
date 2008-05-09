  def test_create_invalid
    <%= class_name %>.any_instance.stub(:valid? => false)
    post :create
    assert_template :new
  end
  
  def test_create_valid
    <%= class_name %>.any_instance.stub(:valid? => true)
    post :create
    assert_redirected_to <%= item_path_for_test %>
  end
