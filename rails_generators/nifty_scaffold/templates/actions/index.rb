  def index
    @<%= plural_model_name %> = <%= model_name %>.all
  end
