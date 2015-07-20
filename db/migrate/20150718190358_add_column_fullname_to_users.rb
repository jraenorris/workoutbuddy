class AddColumnFullnameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string, null: false
    add_index :users, :fullname, unique: true
  end
end
