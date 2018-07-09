class ApplicationController < ActionController::Base
  include HostOnThread

  protect_from_forgery with: :exception
end
