  context "destroy action" do
    should "destroy model and redirect to index action" do
      <%= instance_name %> = <%= class_name %>.first
      delete :destroy, :id => <%= instance_name %>
      assert_redirected_to <%= items_path('url') %>
      assert !<%= class_name %>.exists?(<%= instance_name %>.id)
    end
  end
