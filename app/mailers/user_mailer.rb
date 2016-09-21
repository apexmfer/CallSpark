class UserMailer < ActionMailer::Base
<<<<<<< HEAD
  default from: "demo_inv_mht@mc-mc.com"

=======
  default from: "from@example.com"


     
     
>>>>>>> 1054d5e36b017254b634138066b02849959f6ed4
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
 def reset_password_email(user)
<<<<<<< HEAD
  @user = User.find user.id
  @url  = edit_password_reset_url(@user.reset_password_token)
  mail(:to => user.email,
       :subject => "Your password has been reset")
end
=======
  @user = user
  @url  = edit_password_reset_url(user.reset_password_token)
  mail(:to => user.email,
       :subject => "Your password has been reset")
 end
 
 
 
 
>>>>>>> 1054d5e36b017254b634138066b02849959f6ed4
end
