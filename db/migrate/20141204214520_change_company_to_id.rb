class ChangeCompanyToId < ActiveRecord::Migration
  def change
    
             add_column :customers, :company_id, :integer
             remove_column :customers, :company, :string
      
    
  end
end
