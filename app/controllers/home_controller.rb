class HomeController < ApplicationController

  def index
    redirect_to new_user_session_path unless user_signed_in?
    @missing_dailies_teams = current_user.missing_dailies_teams
  end

end
