
namespace :db do

  desc 'Fill database with sample data'
  task build_admin: :environment do
    dev_email = ENV['dev_email'] or raise "Please specify a 'dev_email=' parameter so items can be generated for you"

    create_admin(dev_email)

  end
end


   def create_admin(dev_email)

         Casein::AdminUser.all.each do |item|
           item.destroy
         end


     # Create admin_user account
     #:login, :name, :email, :time_zone, :access_level, :password, :password_confirmation
     admin_user = Casein::AdminUser.create(:login => 'admin',:name => 'admin', :email => dev_email,
     :password => "password",:password_confirmation => "password")

      puts 'Created casein admin...'
   end
