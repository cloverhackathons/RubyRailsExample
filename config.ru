# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

PRODUCTION = 'https://api.clover.com'
DEVELOPMENT = 'https://sandbox.dev.clover.com'


ENVIRONMENT = DEVELOPMENT
CLIENT_ID = 'CLIENT_ID'
CLIENT_SECRET = 'CLIENT_SECRET'

run Rails.application
