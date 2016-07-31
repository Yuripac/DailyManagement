module TeamAuthentications

  extend ActiveSupport::Concern

  def authenticate_team_member!
    unless @team.member?(current_user)
      flash[:warning] = t("teams.messages.authenticate_failure")
      redirect_to root_path
    end
  end

  def authenticate_team_owner!
    unless @team.owned_by?(current_user)
      flash[:warning] = t("teams.messages.authenticate_failure")
      redirect_to root_path
    end
  end

end
