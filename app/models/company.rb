class Company < ActiveRecord::Base
  # attr_accessible :title, :body

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  has_many :customers

  has_many :calls, :through => :customers


  has_many :favorites, as: :favorited



  def isFavorited(favoriting_user)
    p 'lalalals'
    p favoriting_user.favorites.companies

    if favoriting_user
      return !favoriting_user.favorites.companies.where(:favorited_id => id).empty?
    end

    return false

  end

end
