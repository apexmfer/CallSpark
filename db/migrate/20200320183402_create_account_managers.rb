class CreateAccountManagers < ActiveRecord::Migration
  def change
    create_table :account_managers do |t|
      t.string :firstname
      t.string :lastname
      t.string :initials

      t.timestamps null: false
    end
  end
end
