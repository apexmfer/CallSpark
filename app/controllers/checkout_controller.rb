class CheckoutController < ApplicationController
  def new
  end

  def index
  end


  def create


   #params[]
   #{"utf8"=>"?", "authenticity_token"=>"gAgpT2fBW78ZvsDTPIv5K2lqPr09rKr6XZxNjJZUXOg=",
   #"checkout"=>{"mcmccontact"=>"", "date"=>"", "customeraccount"=>"", "customercontact"=>"", "phone"=>"", "barcode"=>"", "listedbarcodes"=>"5499 5328 "},
   # "action"=>"create", "controller"=>"checkout"}

   allbarcodes = params['checkout']['listedbarcodes'].split(" ") #array of the barcodes being checked out

   expected_date = Date.strptime(params['checkout']['date'], '%m/%d/%Y')

   contact_name_array = params['checkout']['mcmccontact'].split(" ")


   mcmccontact_id = 1


   User.all.each do |contact|
       if nameSimilar(contact.firstname,contact_name_array[0]) and nameSimilar(contact.lastname,contact_name_array[1])

       mcmccontact_id = contact.id
      end

   end

    #render text: mcmccontact_id

   #create new customer account if necessary
    #customer = Customer.where()
   customer = Customer.where(:companyname => params['checkout']['customeraccount']).first

   if customer == nil
   customer = Customer.new(:companyname => params['checkout']['customeraccount'])
   customer.save
   end



   if(allbarcodes.length > 0)
   allbarcodes.each do |barcode|
     part = Partdetail.where(:barcode => barcode).first

     if !part.checked_out
     checkout = Checkout.new(:user_checkingout_id => current_user.id,:user_contact_id => mcmccontact_id,:part_id => part.id,:customer_id => customer.id,
     :customer_contact_name=> params['checkout']['customercontact'],:customer_contact_phone=> params['checkout']['phone'],
     :time_out => Time.new,:expected_time_in => expected_date)


      checkout.save
     end
   end
   end






   redirect_to '/checkout/', notice: allbarcodes.length.to_s.concat(' parts checked out')


 end




    def checkin

     checkout = Checkout.find(params['id'])

      checkout.actual_time_in = Time.new

      checkout.save


     redirect_to '/checkout/', notice: ' part checked in'

   end



 
end
