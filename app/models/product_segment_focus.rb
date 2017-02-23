class ProductSegmentFocus < ActiveRecord::Base

    belongs_to :focused, polymorphic: true

end
