class ApplicationController < ActionController::Base
  include UrlOptionsOnThread

  protect_from_forgery with: :exception
end
