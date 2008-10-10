module Authentication
  def self.included(controller)
    controller.send :helper_method, :current_<%= user_singular_name %>, :logged_in?
  end
  
  def current_<%= user_singular_name %>
    @current_<%= user_singular_name %> ||= <%= user_class_name %>.find(session[:<%= user_singular_name %>_id]) if session[:<%= user_singular_name %>_id]
  end
  
  def logged_in?
    current_<%= user_singular_name %>
  end
  
  def login_required
    unless logged_in?
      flash[:error] = "You must first log in or sign up before accessing this page."
      redirect_to login_url
    end
  end
end
