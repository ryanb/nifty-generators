  def update
    @<%= singular_model_name %> = <%= model_name %>.find(params[:id])
    if @<%= singular_model_name %>.update_attributes(params[:<%= singular_model_name %>])
      flash[:notice] = "Successfully updated <%= name.underscore.humanize.downcase %>."
      redirect_to <%= item_path :instance_variable => true %>
    else
      render :action => 'edit'
    end
  end
