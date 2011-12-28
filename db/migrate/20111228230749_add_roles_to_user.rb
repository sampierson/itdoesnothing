class AddRolesToUser < ActiveRecord::Migration
  def change
    add_column :users, :roles, :string, :default => ['user'].to_yaml, :null => false
    connection.execute "UPDATE users SET roles = '---\n- user\n';"
  end
end
