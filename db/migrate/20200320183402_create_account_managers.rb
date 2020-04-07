class CreateAccountManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :account_managers do |t|
      t.string :firstname
      t.string :lastname
      t.string :initials
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
