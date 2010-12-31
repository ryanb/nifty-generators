  def destroy
    @<%= instance_name %> = <%= class_name %>.find(params[:id])
    @<%= instance_name %>.destroy
    flash[:notice] = "Successfully destroyed <%= class_name.underscore.humanize.downcase %>."
    redirect_to <%= items_url %>
  end
