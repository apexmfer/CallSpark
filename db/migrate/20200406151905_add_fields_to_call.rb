class AddFieldsToCall < ActiveRecord::Migration[5.2]
  def change
    add_column :calls, :called_at, :datetime
    add_column :calls, :initiative_id, :integer
    add_column :calls, :question_for_call, :text
    add_column :calls, :resolution_for_call, :text
    add_column :calls, :notified_account_manager, :boolean
  end
end
