class AddNotesToCustomer < ActiveRecord::Migration
  def change
    
    
     change_table :customers do |t|
 
         t.text :notes
  
    end
    
    
  end
end
