class CreateInitiativeTargets < ActiveRecord::Migration
  def change
    create_table :initiative_targets do |t|

      t.integer :bi_targetted_id
      t.string :bi_targetted_type

      t.integer :initiative_id

      t.timestamps null: false
    end
  end
end
