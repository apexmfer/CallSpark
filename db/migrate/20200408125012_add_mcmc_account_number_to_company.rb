class AddMcmcAccountNumberToCompany < ActiveRecord::Migration[5.2]
  def change
      add_column :companies, :mcmc_account_number, :integer
      add_column :companies, :account_manager_id, :integer
  end
end
