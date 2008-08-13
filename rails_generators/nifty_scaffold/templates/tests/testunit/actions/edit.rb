  def test_edit
    get :edit, :id => <%= class_name %>.first
    assert_template 'edit'
  end
