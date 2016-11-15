class Demohardware < ActiveRecord::Base
  validates :product_id, :presence => true



  belongs_to :part_detail, foreign_key: "product_id"

end
