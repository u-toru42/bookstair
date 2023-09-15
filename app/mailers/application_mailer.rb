class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.gmail[:user_name]
  layout 'mailer'
end
