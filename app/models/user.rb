class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  has_many :favorites
  has_many :favorite_companies, through: :favorites, source: :favorited, source_type: 'Company'

  has_many :favorite_customers, through: :favorite_companies, source: :customers
  has_many :favorite_calls, through: :favorite_companies, source: :calls


  def name

   return firstname + ' ' + lastname

  end

   





end
