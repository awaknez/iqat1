class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com',
          bcc:  Rails.application.credentials.gmail[:address]
  layout 'mailer'
end
