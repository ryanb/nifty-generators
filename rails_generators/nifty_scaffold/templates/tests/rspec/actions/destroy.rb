  it "destroy action should destroy model and redirect to index action" do
    <%= singular_model_name %> = <%= model_name %>.first
    delete :destroy, :id => <%= singular_model_name %>
    response.should redirect_to(<%= items_url %>)
    <%= model_name %>.exists?(<%= singular_model_name %>.id).should be_false
  end
