class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.string :name
      t.boolean :enabled, default:true 

      t.timestamps null: false
    end
  end
end
