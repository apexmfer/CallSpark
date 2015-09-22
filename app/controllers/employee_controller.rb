class EmployeeController < ApplicationController
  skip_before_filter :require_login, only: [:index,:show,:data]

  require 'csv'

  def import

  csv_file_url =  params[:newemployee][:employee_csv_file]

  csv_text = File.read(csv_file_url.path)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
      #Moulding.create!(row.to_hash)


      initials = row.field("initials").gsub(/\s+/, "").upcase
      name = row.field("name")

      matches = Employee.where(:initials => initials)

      if(matches.empty?)
        Employee.create(:initials => initials, :name => name)
        p initials
      end

  end

  redirect_to '/employee', alert: 'Employees created'

  end


end
