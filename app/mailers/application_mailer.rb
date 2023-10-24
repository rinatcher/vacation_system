class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:gmail_smtp, :email)
  layout 'mailer'
end
