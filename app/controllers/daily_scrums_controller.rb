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

  def user_scrums
  end

  def search_user_scrums
    sprint_selection = params[:daily_scrum][:sprint_id]
    @scrum_by_user = DailyScrum.where(:scrum_user => current_user.email, :sprint_id => sprint_selection)
    @user_selected_sprint = Sprint.find(sprint_selection)
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
    params.require(:daily_scrum).permit(:scrum_date, :sprint_id, :scrum_yesterday, :scrum_today, :scrum_blockers, :scrum_user)
  end

end
