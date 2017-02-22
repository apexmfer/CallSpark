class UserMailer < ActionMailer::Base
  default from: "demo_inv_mht@mc-mc.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
 def outside_sales_email(user)
#  @user = User.find user.id
  #@url  = edit_password_reset_url(@user.reset_password_token)

  @company_name = " -- "
  mail(:to => user.email,
       :subject => "New support call for "+ @company_name)
end


end
