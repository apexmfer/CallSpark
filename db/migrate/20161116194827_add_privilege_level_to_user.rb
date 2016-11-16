class AddPrivilegeLevelToUser < ActiveRecord::Migration
  def change
    add_column :users, :privilege_level, :integer
  end
end
