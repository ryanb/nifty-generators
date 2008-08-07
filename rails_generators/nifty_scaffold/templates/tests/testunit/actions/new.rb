  def test_new
    get :new
    assert_template 'new'
  end
