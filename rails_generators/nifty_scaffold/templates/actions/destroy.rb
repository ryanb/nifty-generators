  def destroy
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    @<%= file_name %>.destroy
    redirect_to <%= controller_file_name %>_path
  end
