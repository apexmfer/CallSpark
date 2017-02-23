class Initiative < ActiveRecord::Base

  has_many :initiative_targets

  has_many :bi_target_companies, through: :initiative_targets, source: :bi_targetted,source_type:'BiCustomer'
  has_many :bi_target_vendors, through: :initiative_targets, source: :bi_targetted,source_type:'BiVendor'

  has_many :focused_product_segments, as: :focused, class_name: 'ProductSegmentFocus'
end
