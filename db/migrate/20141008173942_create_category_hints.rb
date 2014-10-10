class CreateCategoryHints < ActiveRecord::Migration
  def change
    create_table :category_hints do |t|

       t.integer :category_id
      t.integer :parent_id
      t.string :text
  
      t.timestamps
    end
  end
end
