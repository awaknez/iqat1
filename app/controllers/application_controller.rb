require 'net/http'
require 'uri'

class ApplicationController < ActionController::Base

  RECAPTCHA_MINIMUM_SCORE = 0.5
  RECAPTCHA_ACTION = 'homepage'

  def verify_recaptcha?(token)
    secret_key = Rails.application.credentials.recaptcha['secret_key']
    uri = URI.parse("https://www.google.com/recaptcha/api/siteverify?secret=#{secret_key}&response=#{token}")
    r = Net::HTTP.get_response(uri)
    j = JSON.parse(r.body)
    # j['success'] && j['score'] > RECAPTCHA_MINIMUM_SCORE && j['action'] == RECAPTCHA_ACTION
    j['success'] && j['score'] > RECAPTCHA_MINIMUM_SCORE 

  end
end