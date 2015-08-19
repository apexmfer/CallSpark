class CreatePartdetails < ActiveRecord::Migration
  def change
    create_table :partdetails do |t|
      t.string :catalog_number
      t.text :description
      t.timestamps
    end
  end
end
