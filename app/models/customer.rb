class Customer < ActiveRecord::Base
   attr_accessible :name, :company_id, :phone_number, :email
   include ActionView::Helpers::NumberHelper


    def company

      return Company.where(id: company_id).first



    end


    def noLastName

      if name.strip.split(" ").length <= 1
          return true
      end

      return false

    end

    def getAutoCompleteName
      if noLastName and company != nil
          return name + " @ " + company.name
      end

      return name

    end

    def getFormattedPhone
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
    end

end
