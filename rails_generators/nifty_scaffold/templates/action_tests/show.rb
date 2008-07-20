  def test_show
    get :show, :id => <%= class_name %>.first
    assert_template 'show'
  end
