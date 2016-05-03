class ApiController < ActionController::Base
  protect_from_forgery with: :exception
  include Authenticable
end
