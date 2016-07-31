class TeamsController < ApplicationController

  include TeamAuthentications

  before_action :set_team, only: [:show, :edit, :update,
                                  :join, :unjoin, :destroy]
  before_action :authenticate_team_owner!, only: [:edit, :update, :destroy]

  def index
    @teams = if params[:search]
               Team.search(params[:search]).order("created_at DESC").page params[:page]
             else
               Team.all.order("created_at DESC").page params[:page]
             end
  end

  def your_teams
    @teams = current_user.membership_teams.order("created_at DESC").page params[:page]
  end

  def new
    @team = Team.new
  end

  def join
    membership = @team.memberships.build(user: current_user)

    if membership.save
      flash[:success] = t(".message.success")
    else
      flash[:danger] = t(".message.failure")
    end
    redirect_to @team
  end

  def unjoin
    if @team.member?(current_user) && !(@team.user == current_user)
      @team.members.destroy(current_user)
      flash[:success] = t(".message.success")
    else
      flash[:danger] = t(".message.failure")
    end
    redirect_to @team
  end

  def create
    @team = current_user.teams.build(team_params)

    if @team.save
      flash[:success] = t(".message.success")
      redirect_to teams_path
    else
      flash[:danger] = t(".message.failure")
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @team.update(team_params)
      flash[:success] = t(".message.success")
      redirect_to teams_path
    else
        flash[:danger] = t(".message.failure")
      render "edit"
    end
  end

  def destroy
    if @team.destroy
      flash[:success] = t(".message.success")
    else
      flash[:danger] = t(".message.failure")
    end
    redirect_to teams_path
  end

  protected

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :description)
  end

end
