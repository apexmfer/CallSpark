require 'elasticsearch/model'


class User < ActiveRecord::Base

  authenticates_with_sorcery!

      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks

  validates :password, presence: true, length: { minimum: 6 }, if: :new_user?
  validates :password_confirmation, presence: true, length: { minimum: 6 }, if: :new_user?

  validates :password, confirmation: true

  validates :email, uniqueness: true

  has_many :project_assignments
  has_many :projects, through: :project_assignments

  has_many :favorites
  has_many :favorite_companies, through: :favorites, source: :favorited, source_type: 'Company'

  has_many :favorite_customers, through: :favorite_companies, source: :customers
  has_many :favorite_calls, through: :favorite_companies, source: :calls

  belongs_to :bi_outside_sales_rep

  def name

   return firstname + ' ' + lastname

  end

  def getProfileName
    return name
  end


  enum privilege_level: {
   "standard": 0,
   "admin": 1,
   "dev": 2
 }


  def is_admin
    return (privilege_level == "admin" or privilege_level == "dev")
  end

  private
  def new_user?
    new_record?
  end

end
