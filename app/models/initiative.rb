class Initiative < ActiveRecord::Base

  has_many :focused_product_segments, as: :focused, class_name: 'ProductSegmentFocus'
  accepts_nested_attributes_for :focused_product_segments, reject_if: :all_blank, allow_destroy: true



  has_many :initiative_targets

  has_many :bi_target_companies, through: :initiative_targets, source: :bi_targetted,source_type:'BiCustomer'
  has_many :bi_target_vendors, through: :initiative_targets, source: :bi_targetted,source_type:'BiVendor'


  def updateTargetsBasedOnProductSegments
    


  end


end
