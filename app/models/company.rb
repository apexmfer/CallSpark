class Company < ActiveRecord::Base
  # attr_accessible :title, :body

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  has_many :customers

  has_many :calls, :through => :customers
  has_many :projects, :foreign_key => :primary_company_id
   has_many :projects_as_secondary, :foreign_key => :secondary_company_id, class_name: 'Project'

  has_many :favorites, as: :favorited



  def isFavorited(favoriting_user)

    if favoriting_user
      return !favoriting_user.favorites.companies.where(:favorited_id => id).empty?
    end

    return false

  end

end
