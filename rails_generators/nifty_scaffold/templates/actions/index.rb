  def index
    @<%= plural_name %> = <%= class_name %>.find(:all)
  end
