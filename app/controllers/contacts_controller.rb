  class ContactsController < ApplicationController
    def new
      @contact = Contact.new
    end
  
    def create
      # binding.pry
      @contact = Contact.new(contact_params)
      if @contact.save
        # お問い合わせフォームの入力内容を自動返信メールに記載
        ContactMailer.send_when_create(@contact).deliver
      else
        render :new
      end
    end

    def policy
      
    end
  
    def howtouse
      
    end
    
    private
  

    def contact_params
      params.require(:contact).permit(:name, :email, :title, :message)
    end
    
  end
  
