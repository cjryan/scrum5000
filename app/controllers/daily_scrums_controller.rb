class DailyScrumsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @daily_scrum = DailyScrum.new(daily_scrum_params)

    @daily_scrum.save
    redirect_to @daily_scrum
    #render plain: params[:daily_scrum].inspect
  end

  def show
    @daily_scrum = DailyScrum.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def edit
  end

  #Strong Parameters, new in Rails 4. This whitelists the
  #Acceptable parameters to be passed to the model.
  private
  def daily_scrum_params
    params.require(:daily_scrum).permit(:scrum_date, :scrum_sprint, :scrum_yesterday, :scrum_today, :scrum_blockers, :scrum_user)
  end

end
