class Company < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor :callcount
  attr_accessible :callcount

  def callcount
    2
  end


end
