class CreateJobRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :job_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
