class <%= session_plural_class_name %>Controller < ApplicationController
<%- if options[:authlogic] -%>
  def new
    @<%= session_singular_name %> = <%= session_class_name %>.new
  end

  def create
    @<%= session_singular_name %> = <%= session_class_name %>.new(params[:<%= session_singular_name %>])
    if @<%= session_singular_name %>.save
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      render :new
    end
  end

  def destroy
    @<%= session_singular_name %> = <%= session_class_name %>.find
    @<%= session_singular_name %>.destroy
    redirect_to root_url, :notice => "You have been logged out."
  end
<%- else -%>
  def new
  end

  def create
    <%= user_singular_name %> = <%= user_class_name %>.authenticate(params[:login], params[:password])
    if <%= user_singular_name %>
      session[:<%= user_singular_name %>_id] = <%= user_singular_name %>.id
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :new
    end
  end

  def destroy
    session[:<%= user_singular_name %>_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
<%- end -%>
end
