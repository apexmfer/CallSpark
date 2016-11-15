module CompanyHelper


  def all_companies_for_autocomplete

  

  list = [];

        Company.all.each do |c|

              list <<  c.name
          end

    return list.to_json



  end
end
