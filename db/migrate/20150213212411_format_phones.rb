class FormatPhones < ActiveRecord::Migration
  def up
    Customer.all.each do |cust|

    strippedphone = cust.phone_number.gsub(/\D/, '')

    cust.phone_number = strippedphone

    cust.save
    end

  end

  def down
  end
end
