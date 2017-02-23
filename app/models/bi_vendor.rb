class BiVendor < ActiveRecord::Base
    validates :no, presence: true, uniqueness:true


    has_many :initiative_targets, as: :targetted
    has_many :initiatives, through: :initiative_targets
end
