  def test_edit
    get :edit
    assert_template :edit
  end
