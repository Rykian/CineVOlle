ActionMailer::Base.smtp_settings = {
  address: ENV['SMTP_HOST'],
  port: ENV['SMTP_PORT'] || 587,
  domain: ENV['SMTP_DOMAIN'],
  authentication: ENV['SMTP_AUTHENTICATION'],
  enable_starttls_auto: ENV['SMTP_STARTTLS'] == 'true',
  user_name: ENV['SMTP_USERNAME'],
  password: ENV['SMTP_PASSWORD']
}

Rails.application.routes.default_url_options[:host] = ENV['DEFAULT_HOST']
