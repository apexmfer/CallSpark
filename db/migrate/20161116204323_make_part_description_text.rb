class MakePartDescriptionText < ActiveRecord::Migration
  def change
      remove_column :partdetails, :description 
        add_column :partdetails, :description, :text
  end
end
