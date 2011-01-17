  def test_destroy
    <%= instance_name %> = <%= class_name %>.first
    delete :destroy, :id => <%= instance_name %>
    assert_redirected_to <%= items_url %>
    assert !<%= class_name %>.exists?(<%= instance_name %>.id)
  end
