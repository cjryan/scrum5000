class DailyScrumsController < ApplicationController
  def index
  end

  def new
  end

  def create
    #@daily_scrum = Daily_scrum.new(daily_scrum_params)

    #@daily_scrum.save
    #redirect_to @daily_scrum
    render plain: params[:daily_scrum].inspect
  end

  def show
    @dail_scrum = Daily_scrum.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def edit
  end
end
