class Favorite < ActiveRecord::Base
  belongs_to :favorited, polymorphic: true
   belongs_to :user


  validates :user_id, uniqueness: {
    scope: [:favorited_id, :favorited_type],
    message: 'can only favorite an item once'
  }

   scope :companies, -> { where(favorited_type: 'Company') }

end
