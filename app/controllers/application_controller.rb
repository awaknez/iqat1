require 'net/http'
require 'uri'

class ApplicationController < ActionController::Base

  RECAPTCHA_MINIMUM_SCORE = 0.5
  RECAPTCHA_ACTION = 'homepage'

  def verify_recaptcha?(token)
    secret_key = Rails.application.credentials.recaptcha:secret_key
    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    response = Net::HTTP.post_form(uri, {})
    result = JSON.parse(response.body)
    
    puts "reCAPTCHA result: #{result}" # コンソールに結果を出力して確認
    # r = Net::HTTP.get_response(uri)
    # j = JSON.parse(r.body)
    result['success'] && result['score'] > RECAPTCHA_MINIMUM_SCORE && result['action'] == RECAPTCHA_ACTION
    # j['success'] && j['score'] > RECAPTCHA_MINIMUM_SCORE 
    binding.pry

  end
end