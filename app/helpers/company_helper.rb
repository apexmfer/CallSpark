module CompanyHelper
  require 'amatch'
   include Amatch

  def all_companies_for_autocomplete

  list = [];

        Company.all.each do |c|
              list << { value:  c.id   , label:   c.name  }
          end

    return list.to_json


  end





  def assignBestMatchingBiCustomerToCompany(company)


    best_match_bi_customer = nil
    best_matching_bi_customer_score = 0
    matching_bi_customer_score = 0

    #amatch using JaroWinkler algo - maybe other algos are better who knows
    amatch = JaroWinkler.new(company.name)


    BiCustomer.all.each do |bi_cust|
      matching_bi_customer_score = amatch.match(bi_cust.name)

      if(matching_bi_customer_score > best_matching_bi_customer_score)
        best_match_bi_customer = bi_cust
        best_matching_bi_customer_score = matching_bi_customer_score
      end

    end


    # we use the best match if and only if it has a higher score than 50%
    if best_match_bi_customer && best_matching_bi_customer_score > 0.96
      p "matched " + company.name + " with " + best_match_bi_customer.name + " -- " + best_matching_bi_customer_score.to_s
        company.update_attributes(bi_customer_no: best_match_bi_customer.no)
    else
      company.update_attributes(bi_customer_no: nil)

    end

  end


end
