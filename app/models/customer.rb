class Customer < ActiveRecord::Base
   #attr_accessible :name, :company_id, :phone_number, :email, :region_id
   include ActionView::Helpers::NumberHelper


   include Elasticsearch::Model
   include Elasticsearch::Model::Callbacks


    belongs_to :region
    belongs_to :company
    has_many :calls

    def company

      return Company.where(id: company_id).first

    end

    def getCompanyName

      if company != nil
          return company.name
      end

      return ''
    end


    def noLastName

      if name.strip.split(" ").length <= 1
          return true
      end

      return false

    end

    def getAutoCompleteName
      if company != nil
          return name + " @ " + company.name
      end

      return name

    end

    def getFormattedPhone

      if phone_number
        strippedphone = phone_number.gsub(/\D/, '')

        local_number = nil;
        ext = nil;

        if strippedphone.length <= 10
          local_number = strippedphone;
        else
          local_number = strippedphone[0..9];
          ext = strippedphone[10..strippedphone.length]
        end

        return number_to_phone(local_number ,   area_code: (strippedphone.length > 9), extension: ext)
      else
        return ''
      end
    end




end
