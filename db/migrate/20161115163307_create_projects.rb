class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.integer :customer_id
      t.integer :primary_company_id
      t.integer :secondary_company_id
      t.string :name
      t.string :status
      t.string :quote_id
      t.float :cost_estimate
      t.datetime :start_date
      t.datetime :data_received_date
      t.datetime :sized_date
      t.datetime :proposal_date
      t.datetime :follow_up_date

      t.timestamps null: false
    end
  end
end
