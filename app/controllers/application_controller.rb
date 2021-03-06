class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :delete_pup_from_session, :set_titles 
  def delete_pup_from_session
    if session[:pup]
      session.delete(:pup)
    end
  end

  def set_titles
    @mission = Text.find_by_id(1).title
    @background = Text.find_by_id(2).title
    @goals = Text.find_by_id(3).title
    @how_you_can_help = Text.find_by_id(4).title
  end
end
