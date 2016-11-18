module CustomerHelper


  def all_customers_for_autocomplete

    list = [];

          Customer.all.each do |c|

                list <<  { value:  c.id   , label:   c.getAutoCompleteName  }

            end

      return list.to_json


  end
end
