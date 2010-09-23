class <%= user_plural_class_name %>Controller < ApplicationController
  def new
    @<%= user_singular_name %> = <%= user_class_name %>.new
  end

  def create
    @<%= user_singular_name %> = <%= user_class_name %>.new(params[:<%= user_singular_name %>])
    if @<%= user_singular_name %>.save
    <%- unless options[:authlogic] -%>
      session[:<%= user_singular_name %>_id] = @<%= user_singular_name %>.id
    <%- end -%>
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
