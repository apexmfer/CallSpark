module UsersHelper


    def all_users_for_autocomplete



    list = [];

          User.all.each do |c|
                list << { value:  c.id   , label:   c.name  }
            end

      return list.to_json



    end


    def assignBestMatchingBiOutsideSalesRepToUser(user)

      formatted_user_code = user.bi_outside_sales_rep_code.strip.downcase

      BiOutsideSalesRep.each do |rep|

        formatted_rep_code = rep.code.strip.downcase
        if formatted_rep_code == formatted_user_code
          user.update_attributes(bi_outside_sales_rep_id: rep.id)
          p 'Matched ' + user.getProfileName + ' with ' + rep.getProfileName
        end

      end
    end


end
