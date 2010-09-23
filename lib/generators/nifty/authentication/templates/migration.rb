class Create<%= user_plural_class_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= user_plural_name %> do |t|
      t.string :username
      t.string :email
    <%- if options[:authlogic] -%>
      t.string :persistence_token
      t.string :crypted_password
    <%- else -%>
      t.string :password_hash
    <%- end -%>
      t.string :password_salt
      t.timestamps
    end
  end

  def self.down
    drop_table :<%= user_plural_name %>
  end
end
