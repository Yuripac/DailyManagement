class DailiesController < ApplicationController

  before_action :set_team
  before_action :set_daily, only: [:show, :edit, :update]
  before_action :check_user_member!, only: [:edit, :update, :new, :create]
  before_action :check_user_owner!, only: [:index, :show]

  def index
    @dailies = @team.dailies_grouped_by_created_at
  end

  def show
  end

  def new
    @daily = Daily.new
  end

  def create
    @daily = @team.dailies.build(daily_params)
    @daily.user = current_user
    if @daily.save
      flash[:success] = t(".message.success")
      redirect_to team_path(@team)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @daily.update(daily_params)
      flash[:success] = t(".message.success")
      redirect_to team_path(@team)
    else
      flash[:danger] = t(".message.failure")
      render "edit"
    end
  end

  private

  def check_user_owner!
    unless @team.user == current_user
      flash[:warning] = t(".user_not_owner")
      redirect_to root_path
    end
  end

  def check_user_member!
    unless @team.users.include?(current_user)
      flash[:warning] = t(".user_not_member")
      redirect_to root_path
    end
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_daily
    @daily = @team.dailies.find(params[:id])
  end

  def daily_params
    params.require(:daily).permit(:done, :doing, :impediments)
  end
end
