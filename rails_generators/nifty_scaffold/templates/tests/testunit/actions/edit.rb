  def test_edit
    get :edit, :id => <%= model_name %>.first
    assert_template 'edit'
  end
