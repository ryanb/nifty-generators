class <%= sessions_class_name %>Controller < ApplicationController
  def new
  end
  
  def create
    <%= user_singular_name %> = <%= user_class_name %>.authenticate(params[:login], params[:password])
    if <%= user_singular_name %>
      session[:<%= user_singular_name %>_id] = <%= user_singular_name %>.id
      flash[:notice] = "Logged in successfully."
      redirect_to root_url
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  def destroy
    session[:<%= user_singular_name %>_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
