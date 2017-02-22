class AddSalesRepIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bi_outside_sales_rep_id, :integer
    add_column :users, :bi_outside_sales_rep_code, :string
    add_column :users, :receive_outside_sales_emails, :boolean
  end
end
