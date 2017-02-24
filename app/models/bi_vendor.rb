class BiVendor < ActiveRecord::Base
    validates :no, presence: true, uniqueness:true

    has_many :bi_quotes, foreign_key: :bi_vendor_no
    has_many :bi_orders, foreign_key: :bi_vendor_no

    has_many :initiative_targets, as: :targetted
    has_many :initiatives, through: :initiative_targets

    has_many :sales_metrics, as: :measured

end
