  def show
    @<%= instance_name %> = <%= class_name %>.find(params[:id])
  end
