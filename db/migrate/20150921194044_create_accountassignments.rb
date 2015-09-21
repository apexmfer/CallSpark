class CreateAccountassignments < ActiveRecord::Migration
  def change
    create_table :accountassignments do |t|

      t.integer :employee_id
      t.integer :bpid

      t.timestamps
    end
  end
end
