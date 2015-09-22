class AccountAssignmentController < ApplicationController

  require 'csv'

  def import

  csv_file_url =  params[:newassignment][:assignment_csv_file]

  csv_text = File.read(csv_file_url.path)
  csv = CSV.parse(csv_text, :headers => true)

  Thread.new do

    Accountassignment.delete_all

    csv.each do |row|
      #Moulding.create!(row.to_hash)


      initials = row.field("initials").gsub(/\s+/, "")
      bpid = row.field("bpid").gsub(/\s+/, "").to_i

      employee = Employee.where(:initials => initials).first
      assignments = Accountassignment.where(:bpid => bpid)



      if(employee and assignments.empty?)
        Accountassignment.create(:employee_id => employee.id, :bpid => bpid)
        p bpid
        p employee
      end



    end


  end

  redirect_to '/account_assignment', alert: 'Assignments created'

  end



end
