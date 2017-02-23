class Initiative < ActiveRecord::Base

  has_many :initiative_targets

  has_many :bi_targets, through: :initiative_targets, source: :bi_targetted


end
