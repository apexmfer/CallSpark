class AddFieldsToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :job_role_id, :integer
  end
end
