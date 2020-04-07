class AddFieldsToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :service_contract_type, :integer
  end
end
