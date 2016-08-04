class DailiesController < ApplicationController

  include TeamAuthentications

  before_action :set_team
  before_action :set_daily, only: [:show, :edit, :update]
  before_action :authenticate_team_member!, only: [:edit, :update, :new, :create]
  before_action :authenticate_daily_owner!, only: [:edit, :update]
  before_action :authenticate_team_owner!,  only: [:index, :show]

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

  protected

  def authenticate_daily_owner!
    unless @daily.user == current_user
      flash[:warning] = t("dailies.messages.authenticate_failure")
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
