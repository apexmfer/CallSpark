

class OutsideSalesMailer < ActionMailer::Base
  default from: "mcmctechcloud@mc-mc.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
     def outside_sales_email(user,call)

       @call = call

       @url = Rails.application.routes.url_helpers.calls_path(id: call.id)

       @company_name = @call.getCompanyName

       @body = @call.text

      mail(:to => user.email,
           :subject => "New techsupport call - "+ @company_name)

    end


end
