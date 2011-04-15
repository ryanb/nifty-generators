class <%= resource_path.pluralize.camelize %>Controller < ApplicationController
  <%= controller_methods :actions %>
end
