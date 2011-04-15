  context "destroy action" do
    should "destroy model and redirect to index action" do
      <%= singular_model_name %> = <%= model_name %>.first
      delete :destroy, :id => <%= singular_model_name %>
      assert_redirected_to <%= items_url %>
      assert !<%= model_name %>.exists?(<%= singular_model_name %>.id)
    end
  end
