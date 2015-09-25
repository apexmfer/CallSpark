class EditPartdetail < ActiveRecord::Migration
  def change

    change_column :partdetails, :description, :integer
    add_column :partdetails, :familyID, :integer
    add_column :partdetails, :typeID, :integer
    add_column :partdetails, :subtypeID, :integer

  end
end
