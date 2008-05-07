  def update
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
      redirect_to @<%= file_name %>
    else
      render :action => 'edit'
    end
  end
