class AccountManager < ActiveRecord::Base


    validates :initials, presence: true, uniqueness: true

    belongs_to :user

end
