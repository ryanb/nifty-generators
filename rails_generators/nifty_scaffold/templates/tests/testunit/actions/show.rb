  def test_show
    get :show, :id => <%= model_name %>.first
    assert_template 'show'
  end
