class Partdetail < ActiveRecord::Base
  # attr_accessible :title, :body


   attr_accessible :description


  def getDescription
      partDescription = ProductDescriptions.find_by_id(description)
      if(partDescription)
        return partDescription.text
      end
      return description
  end




end
