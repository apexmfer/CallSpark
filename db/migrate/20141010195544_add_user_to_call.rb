class AddUserToCall < ActiveRecord::Migration
  def change
     change_table :calls do |t|
 
         t.integer :user_id
  
    end
end
   
end
