  def show
    @<%= file_name %> = <%= class_name %>.find(params[:id])
  end
