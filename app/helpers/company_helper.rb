module CompanyHelper


  def all_companies_for_autocomplete

  list = [];

        Company.all.each do |c|
              list << { value:  c.id   , label:   c.name  }
          end

    return list.to_json


  end
end
