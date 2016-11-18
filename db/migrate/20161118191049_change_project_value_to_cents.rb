class ChangeProjectValueToCents < ActiveRecord::Migration
  def change
 
    remove_column :projects, :cost_estimate
      add_column :projects, :cost_estimate_cents, :integer

  end
end
