class Create<%= user_plural_class_name %> < ActiveRecord::Migration
  def self.up
    create_table :<%= user_plural_name %> do |t|
      t.column :username,      :string
      t.column :email,         :string
      t.column :password_hash, :string
      t.column :password_salt, :string
      t.timestamps
    end
  end
  
  def self.down
    drop_table :<%= user_plural_name %>
  end
end
