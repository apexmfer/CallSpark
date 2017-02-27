class Company < ActiveRecord::Base
  # attr_accessible :title, :body
  require 'amatch'
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

   include Amatch

   include CompanyHelper


   has_many :focused_product_segments, as: :focused, class_name: 'ProductSegmentFocus'
   accepts_nested_attributes_for :focused_product_segments, reject_if: :all_blank, allow_destroy: true


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


  def findCloseMatchBICustomers

    close_matches = []

      #amatch using JaroWinkler algo - maybe other algos are better who knows
      amatch = JaroWinkler.new(name)


      BiCustomer.all.each do |bi_cust|
        matching_bi_customer_score = amatch.match(bi_cust.name)

        if(matching_bi_customer_score > 0.8)
            close_matches << bi_cust
        end

      end


      return close_matches
  end

end
