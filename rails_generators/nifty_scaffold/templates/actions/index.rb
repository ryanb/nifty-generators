  def index
    @<%= controller_file_name %> = <%= class_name %>.find(:all)
  end
