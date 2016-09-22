class Region < ActiveRecord::Base
  attr_accessible :name

   has_many :customers
   has_many :calls
end
