  def create
    @<%= instance_name %> = <%= class_name %>.new(params[:<%= instance_name %>])
    if @<%= instance_name %>.save
      flash[:notice] = "Successfully created <%= class_name.underscore.humanize.downcase %>."
      redirect_to <%= item_path :instance_variable => true %>
    else
      render :action => 'new'
    end
  end
