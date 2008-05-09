require File.dirname(__FILE__) + '/../spec_helper'
 
describe <%= plural_class_name %>Controller do
  fixtures :all
  integrate_views
  
  <%= controller_methods :action_specs %>
end
