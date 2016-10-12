class Company < ActiveRecord::Base
  # attr_accessible :title, :body

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


  has_many :customers

  has_many :calls, :through => :customers

end
