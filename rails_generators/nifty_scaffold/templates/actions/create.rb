  def create
    @<%= singular_name %> = <%= class_name %>.new(params[:<%= singular_name %>])
    if @<%= singular_name %>.save
      redirect_to @<%= singular_name %>
    else
      render :action => 'new'
    end
  end
