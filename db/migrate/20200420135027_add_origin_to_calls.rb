class AddOriginToCalls < ActiveRecord::Migration[5.2]
  def change
      add_column :calls, :origin_type, :integer
  end
end
