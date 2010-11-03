  def update
    @<%= instance_name %> = <%= class_name %>.find(params[:id])
    if @<%= instance_name %>.update_attributes(params[:<%= instance_name %>])
      flash[:notice] = "Successfully updated <%= model_name.underscore.humanize.downcase %>."
      redirect_to <%= item_path('url') %>
    else
      render :action => 'edit'
    end
  end
