  def destroy
    @<%= singular_model_name %> = <%= model_name %>.find(params[:id])
    @<%= singular_model_name %>.destroy
    flash[:notice] = "Successfully destroyed <%= name.underscore.humanize.downcase %>."
    redirect_to <%= items_url %>
  end
