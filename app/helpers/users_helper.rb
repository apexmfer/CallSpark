module UsersHelper


    def all_users_for_autocomplete



    list = [];

          User.all.each do |c|
                list << { value:  c.id   , label:   c.name  }
            end

      return list.to_json



    end


end
