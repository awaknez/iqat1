class ContactMailer < ApplicationMailer
    def send_when_create(contact)
    @contact = contact
    mail(
      from:     "情報1 一問一答トレーニングGYM <#{Rails.application.credentials.gmail[:address]}>",
      to:       @contact.email,
      subject:  "お問合せありがとうございます - 【#{@contact.title}】"
    )
  end
end
