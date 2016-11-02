class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true

  has_many :favorites
 has_many :favorite_companies, through: :favorites, source: :favorited, source_type: 'Company'


  def name

   return firstname + ' ' + lastname

  end

  def favorite_company_calls
      calls = []

      favorite_companies.each do |company|
        calls << company.calls



      end

      return calls.flatten
  end





end
