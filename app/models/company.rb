class Company < ActiveRecord::Base
  # attr_accessible :title, :body

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  has_many :customers

  has_many :calls, :through => :customers
  has_many :projects, :foreign_key => :primary_company_id
   has_many :projects_as_secondary, :foreign_key => :secondary_company_id, class_name: 'Project'

  has_many :favorites, as: :favorited

  #filled in by smart scripts
  belongs_to :bi_customer, class_name: "BiCustomer", foreign_key: "bi_customer_no"


  def isFavorited(favoriting_user)

    if favoriting_user
      return !favoriting_user.favorites.companies.where(:favorited_id => id).empty?
    end

    return false

  end



  def getOutsideSalesRep
    if bi_customer  
      return bi_customer.bi_outside_sales_rep
    end
  end

end
