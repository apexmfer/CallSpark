class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|

      t.string :initials
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
