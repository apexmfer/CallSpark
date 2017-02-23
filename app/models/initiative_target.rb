class InitiativeTarget < ActiveRecord::Base

  belongs_to :bi_targetted, polymorphic: true#, :primary_key => 'no'
  belongs_to :initiative

end
