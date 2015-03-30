class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :delete_pup_from_session
  def delete_pup_from_session
    if session[:pup]
      session.delete(:pup)
    end
  end
end
