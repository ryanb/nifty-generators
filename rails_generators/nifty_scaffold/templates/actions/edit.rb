  def edit
    @<%= singular_name %> = <%= class_name %>.find(params[:id])
  end
