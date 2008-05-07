  def create
    @<%= singular_name %> = <%= class_name %>.new(params[:<%= singular_name %>])
    if @<%= singular_name %>.save
      redirect_to <%= item_path %>
    else
      render :action => 'new'
    end
  end
