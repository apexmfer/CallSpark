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

#  enum product_segment_types: {
#   "AC Motor": 0,
#   "PT Gearing": 1,
#   "Linear Actuator": 2,
#   "Rack and Pinion": 3,
#   "Precision Gearing": 4,
#   "Guidance and Bearings": 5,
#   "VFD": 6,
#   "Servo": 7,
 #}




 enum status: {
  "Data Collection": 0,
  "Quoted": 1,
  "Ordered": 2
}


def self.product_segment_types
  return ProductSegment.all
end

def self.product_segment_type_names
  return ProductSegment.all.map{|segment|  segment.name   }
end


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

  def self.to_csv
   CSV.generate do |csv|
     #csv << column_names
     #all.each do |project|
    #   csv << project.attributes.values_at(*column_names)
    # end

     csv << ["ID","Entry Date","Data Received Date","Sizing Completed Date","Solution Proposed Date","Follow Up Date","Project Name","Primary Account","Secondary Account","Project Segments","Assigned Engineers","Estimated Cost","Status"]

     all.each do |project|
       csv << [project.id,project.created_at, project.data_received_date, project.sized_date, project.proposal_date, project.follow_up_date , project.name,project.primary_company_name,project.secondary_company_name, project.segments_description, project.assigned_engineers_description, project.estimated_cost_description, project.status_description]
     end

   end
 end

 def segments_description

  return product_segment_list.to_s.humanize
 end
 def assigned_engineers_description
   result = ""
   assigned_users.each do |user|
     result += (user.name + ", ")
   end
  return result
 end
 def estimated_cost_description
   return ActionController::Base.helpers.humanized_money_with_symbol cost_estimate
 end

end
