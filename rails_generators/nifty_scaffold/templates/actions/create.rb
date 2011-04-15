  def create
    @<%= singular_model_name %> = <%= model_name %>.new(params[:<%= singular_model_name %>])
    if @<%= singular_model_name %>.save
      flash[:notice] = "Successfully created <%= name.underscore.humanize.downcase %>."
      redirect_to <%= item_path :instance_variable => true %>
    else
      render :action => 'new'
    end
  end
