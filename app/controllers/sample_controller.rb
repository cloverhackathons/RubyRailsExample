class SampleController < ApplicationController
  require 'net/http'
  require 'uri'


  class << self
    attr_accessor :MERCHANT_ID
    attr_accessor :ACCESS_TOKEN
  end

  def set_merchant(mID)
    self.class.MERCHANT_ID = mID
  end

  def set_token(token)
    self.class.ACCESS_TOKEN = token
  end

  def index
  	code = request.GET['code']
  	if not code
  		redirect_to("#{ENVIRONMENT}/oauth/authorize?client_id=#{CLIENT_ID}")
  	else
      set_merchant(request.GET['merchant_id'])
  		redirect_to("/oauth_callback?code=#{code}")
  	end
  end

  def oauth_callback
  	code = request.GET['code']
  	request_url = "#{ENVIRONMENT}/oauth/token?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&code=#{code}" 
    
    uri = URI.parse(request_url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.use_ssl = true

    response = http.request(request)
    set_token(JSON(response.body)["access_token"])
    redirect_to("/merchant_details")
  end

  def merchant_details
    request_uri = "#{ENVIRONMENT}/v3/merchants/#{self.class.MERCHANT_ID}"

    uri = URI.parse(request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http.use_ssl = true
    request.initialize_http_header({"Authorization"=>"Bearer #{self.class.ACCESS_TOKEN}"})
    response = http.request(request)

    render :json => JSON.pretty_generate(JSON(response.body))
  end

end
