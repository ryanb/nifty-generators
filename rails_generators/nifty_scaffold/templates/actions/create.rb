  def create
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])
    if @<%= file_name %>.save
      redirect_to @<%= file_name %>
    else
      render :action => 'new'
    end
  end
