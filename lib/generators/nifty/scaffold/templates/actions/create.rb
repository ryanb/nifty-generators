  def create
    @<%= instance_name %> = <%= class_name %>.new(params[:<%= instance_name %>])
    if @<%= instance_name %>.save
      flash[:notice] = "Successfully created <%= model_name.underscore.humanize.downcase %>."
      redirect_to <%= item_path('url') %>
    else
      render :action => 'new'
    end
  end
