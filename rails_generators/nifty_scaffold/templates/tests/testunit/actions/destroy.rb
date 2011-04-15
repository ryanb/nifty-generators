  def test_destroy
    <%= singular_model_name %> = <%= model_name %>.first
    delete :destroy, :id => <%= singular_model_name %>
    assert_redirected_to <%= items_url %>
    assert !<%= model_name %>.exists?(<%= singular_model_name %>.id)
  end
