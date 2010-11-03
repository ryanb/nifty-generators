class Create<%= plural_class_name.delete('::') %> < ActiveRecord::Migration
  def self.up
    create_table <%= table_name.to_sym.inspect %> do |t|
    <%- for attribute in model_attributes -%>
      t.<%= attribute.type %> :<%= attribute.name %>
    <%- end -%>
    <%- unless options[:skip_timestamps] -%>
      t.timestamps
    <%- end -%>
    end
  end

  def self.down
    drop_table :<%= table_name %>
  end
end
