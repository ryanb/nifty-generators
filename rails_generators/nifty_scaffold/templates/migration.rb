class Create<%= model_name.pluralize.delete('::') %> < ActiveRecord::Migration
  def self.up
    create_table :<%= plural_model_name %> do |t|
    <%- for attribute in attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
    <%- end -%>
    <%- unless options[:skip_timestamps] -%>
      t.timestamps
    <%- end -%>
    end
  end

  def self.down
    drop_table :<%= plural_model_name %>
  end
end
