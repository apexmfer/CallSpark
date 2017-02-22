class BiOutsideSalesRep < ActiveRecord::Base
    validates :code, presence: true, uniqueness:true
    has_many :bi_customers
    has_one :user

      def getProfileName
        return name + ' (' + code.strip + ')'
      end


      def getUser
        if user
          return user 
        end
      end
end
