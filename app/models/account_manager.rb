class AccountManager < ActiveRecord::Base


    validates :initials, presence: true, uniqueness: true

    belongs_to :user, optional: true


    def name
      return self.firstname + " " + self.lastname
    end

end
