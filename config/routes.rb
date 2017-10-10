Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'sample#index'
  get '/oauth_callback', to: 'sample#oauth_callback'

end
