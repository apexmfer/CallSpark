class BiInsideSalesRep < ActiveRecord::Base
  validates :code, presence: true, uniqueness:true
  has_many :bi_customers


  def getProfileName
    return name + ' (' + code.strip + ')'
  end

end
