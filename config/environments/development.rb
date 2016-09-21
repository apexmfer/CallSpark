Testlog::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  
<<<<<<< HEAD
  config.action_mailer.default_url_options= {:host => 'mail.macnet-ad.mc-mc.com'}
  config.action_mailer.raise_delivery_errors = true
   config.action_mailer.perform_deliveries = true
   
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => 'mail.macnet-ad.mc-mc.com',
    :port => '587',
    :authentication => :login,
    :user_name => Figaro.env.SMTP_USERNAME,
    :password => Figaro.env.SMTP_PASSWORD, #ENV['SMTP_PASSWORD']
    :domain => 'mc-mc.com',
    :enable_starttls_auto => true
  }
    #run this in cmd...
    #export SMTP_USERNAME="myname@gmail.com"
    
=======
  
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  user_name:            'indiebucket',
  password:             'stocks10',
  authentication:       'plain',
  enable_starttls_auto: true 
   }
  
config.action_mailer.perform_deliveries = true
config.action_mailer.raise_delivery_errors = true
config.action_mailer.default_url_options = { :host => 'localhost' }


>>>>>>> 1054d5e36b017254b634138066b02849959f6ed4
end
