  def show
    @<%= singular_model_name %> = <%= model_name %>.find(params[:id])
  end
