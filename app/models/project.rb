class Project < ActiveRecord::Base

  validates :user_id, :name, :primary_company_id,  :presence => true

  has_many :project_assignments
  has_many :assigned_users, through: :project_assignments, source: :user, source_type: 'Users'

  belongs_to :user  #the creator
  belongs_to :customer
  belongs_to :primary_company, class_name: "Company"
  belongs_to :secondary_company, class_name:  "Company"

  acts_as_commentable

  acts_as_taggable_on :product_segments

  enum product_segment_types: {
   "AC Motor": 0,
   "PT Gearing": 1,
   "Linear Actuator": 2,
   "Rack and Pinion": 3,
   "Precision Gearing": 4,
   "Guidance and Bearings": 5,
   "VFD": 6,
   "Servo": 7,
 }

 enum status: {
  "Data Collection": 0,
  "Quoted": 1,
  "Ordered": 2
}

  def status_description
      return "In Progress"
  end

 extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :name
    ]
  end

end
