class ProjectAssignment < ActiveRecord::Base
  validates :user_id, :project_id, :presence => true

  belongs_to :project
  belongs_to :user
end
