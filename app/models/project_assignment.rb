class ProjectAssignment < ActiveRecord::Base
  validates :user_id, :project_id, :presence => true
  validates :user_id, uniqueness: { scope: :project_id } #unique based on 2 things

  belongs_to :project
  belongs_to :user
end
