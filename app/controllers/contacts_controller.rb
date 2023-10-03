  class ContactsController < ApplicationController
    def new
      @contact = Contact.new
      # reCAPTCHAのサイトキーを設定
      @recaptcha_site_key = '6Lc97mQoAAAAAKfEq5ADy8K8Fht55aKEoENlrFIk'

    end
  
    def create
      @contact = Contact.new(contact_params)
      # reCAPTCHAの検証
      unless verify_recaptcha?(params[:recaptcha_token])
        flash.now[:recaptcha_error] = I18n.t('recaptcha.errors.verification_failed')
        return render action: :new
      end
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
  
