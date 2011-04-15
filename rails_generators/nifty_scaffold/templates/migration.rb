class Create<%= model_name.pluralize.delete('::') %> < ActiveRecord::Migration
  def self.up
    create_table :<%= model_name.pluralize.underscore.gsub('::', '_') %> do |t|
    <%- for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
    <%- end -%>
    <%- unless options[:skip_timestamps] -%>
      t.timestamps
    <%- end -%>
    end
  end

  def self.down
    drop_table :<%= model_name.pluralize.underscore.gsub('::', '_') %>
  end
end
