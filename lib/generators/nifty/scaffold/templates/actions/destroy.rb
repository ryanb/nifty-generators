  def destroy
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
    @<%= singular_name %>.destroy
    flash[:notice] = "Successfully destroyed <%= model_name.underscore.humanize.downcase %>."
    redirect_to <%= items_path('url') %>
  end
