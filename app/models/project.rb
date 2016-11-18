class Project < ActiveRecord::Base

  validates :user_id, :name, :primary_company_id,  :presence => true

  has_many :project_assignments
  has_many :assigned_users, through: :project_assignments, source: :user

  belongs_to :user  #the creator
  belongs_to :customer
  belongs_to :primary_company, class_name: "Company"
  belongs_to :secondary_company, class_name:  "Company"

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks


  monetize :cost_estimate_cents, :allow_nil => true

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

   result = "Collecting Data"

    if date_exists_in_past(data_received_date)

      result = "Sizing the Solution"
      if date_exists_in_past(sized_date)

          result = "Building a Proposal"
        if date_exists_in_past(proposal_date)

            result = "Quoted"
          if date_exists_in_past(follow_up_date)
              result = "Complete and Followed Up"
          end

        end

      end

    end


      return result
  end


  def date_exists_in_past(date)
    return date && date < Time.current
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

  def primary_company_name
    if primary_company
      return primary_company.name
    end
  end

  def secondary_company_name
    if secondary_company
      return secondary_company.name
    end
  end


  def customer_name
    if customer
      return customer.name
    end
  end

end
