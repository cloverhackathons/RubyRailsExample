class SampleController < ApplicationController

  def index
  	code = request.GET['code']
  	if not code
  		redirect_to("#{ENVIRONMENT}/oauth/authorize?client_id=#{CLIENT_ID}")
  	else
  		redirect_to("/oauth_callback?code=#{code}")
  	end
  end

  def oauth_callback
  	code = request.GET['code']
  	request_url = "#{ENVIRONMENT}/oauth/token?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&code=#{code}" 
  	response = Net::HTTP.get_response(URI.parse(request_url))
  	render json: response.body
  end
end