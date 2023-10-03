require 'net/http'
require 'uri'

class ApplicationController < ActionController::Base

  RECAPTCHA_MINIMUM_SCORE = 0.5
  RECAPTCHA_ACTION = 'homepage'

  def verify_recaptcha?(token)
    secret_key =  Rails.application.credentials.recaptcha[:secret_key]
    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    response = Net::HTTP.post_form(uri, {})
    result = JSON.parse(response.body)
    
    # コンソールに結果を出力して確認
    # puts "reCAPTCHA result: #{result}"

    result['success'] && result['score'] > RECAPTCHA_MINIMUM_SCORE && result['action'] == RECAPTCHA_ACTION

  end
end