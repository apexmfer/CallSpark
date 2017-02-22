class AddBiCustomerNoToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :bi_customer_no, :integer
  end
end
