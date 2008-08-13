  context "destroy action"
    should "destroy model and redirect to index action"
      <%= singular_name %> = <%= class_name %>.first
      delete :destroy, :id => <%= singular_name %>
      assert_redirected_to <%= plural_name %>_url
      assert !<%= class_name %>.exists?(<%= singular_name %>.id)
    end
  end
