class Project < ActiveRecord::Base

  validates :user_id, :presence => true

  has_many :project_assignments
  has_many :assigned_users, through: :project_assignments, source: :user, source_type: 'Users'

  belongs_to :user  #the creator

  

end
