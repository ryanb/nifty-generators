# This module is included in your application controller which makes
# several methods available to all controllers and views. Here's a
# common example you might add to your application layout file.
#
#   <%% if logged_in? %>
#     Welcome <%%=h current_<%= user_singular_name %>.username %>! Not you?
#     <%%= link_to "Log out", logout_path %>
#   <%% else %>
#     <%%= link_to "Sign up", signup_path %> or
#     <%%= link_to "log in", login_path %>.
#   <%% end %>
#
# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
#
#   before_filter :login_required, :except => [:index, :show]
module Authentication
  def self.included(controller)
    controller.send :helper_method, :current_<%= user_singular_name %>, :logged_in?, :redirect_to_target_or_default
    controller.filter_parameter_logging :password
  end

<%- if options[:authlogic] -%>
  def current_<%= session_singular_name %>
    return @current_<%= session_singular_name %> if defined?(@current_<%= session_singular_name %>)
    @current_<%= session_singular_name %> = <%= session_class_name %>.find
  end

  def current_<%= user_singular_name %>
    return @current_<%= user_singular_name %> if defined?(@current_<%= user_singular_name %>)
    @current_<%= user_singular_name %> = current_<%= session_singular_name %> && current_<%= session_singular_name %>.record
  end
<%- else -%>
  def current_<%= user_singular_name %>
    @current_<%= user_singular_name %> ||= <%= user_class_name %>.find(session[:<%= user_singular_name %>_id]) if session[:<%= user_singular_name %>_id]
  end
<%- end -%>

  def logged_in?
    current_<%= user_singular_name %>
  end

  def login_required
    unless logged_in?
      flash[:error] = "You must first log in or sign up before accessing this page."
      store_target_location
      redirect_to login_url
    end
  end

  def redirect_to_target_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  private

  def store_target_location
    session[:return_to] = request.request_uri
  end
end
