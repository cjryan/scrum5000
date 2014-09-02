class DailyScrumsController < ApplicationController
  def index
    @daily_scrums = DailyScrum.all
  end

  def new
    #This is present to prevent 'nil' errors when the form is loaded on the 'new' action
    @daily_scrum = DailyScrum.new
  end

  def create
    @daily_scrum = DailyScrum.new(daily_scrum_params)

    #If the form is successfully saved, display the saved info. Else, render the error.
    if @daily_scrum.save
      redirect_to @daily_scrum
    else
      render 'new'
    end
    #render plain: params[:daily_scrum].inspect
  end

  def show
    @daily_scrum = DailyScrum.find(params[:id])
  end

  def user_scrums
  end

  def search_user_scrums
    if params[:daily_scrum]
      sprint_selection = params[:daily_scrum][:sprint_id]
      #For use in the display
      @user_selected_sprint = Sprint.find(sprint_selection)
    else
      sprint_selection = params[:sprint_id]
      #For use in the display
      @user_selected_sprint = Sprint.find(sprint_selection)
    end
    #Find all scrums in the sprint by user
    if params[:daily_scrum]
      scrum_email = User.find(params[:daily_scrum][:user_id])[:email]
    else
      scrum_email = User.find(params[:user_id])[:email]
    end
    @scrum_by_user = DailyScrum.where(:scrum_user => scrum_email, :sprint_id => sprint_selection)
  end

  def all_scrums
  end

  def search_all_scrums
    if params[:daily_scrum]
      sprint_selection = params[:daily_scrum][:sprint_id]
      #For use in the display
      @selected_sprint = Sprint.find(sprint_selection)
    else
      sprint_selection = params[:sprint_id]
      #For use in the display
      @selected_sprint = Sprint.find(sprint_selection)
    end
    #Find all scrums in the sprint
    @all_scrums = DailyScrum.where(:sprint_id => sprint_selection).order('scrum_date ASC')

    #Return all unique dates to group scrums
    @date_headers = DailyScrum.select(:scrum_date).distinct.where(:sprint_id => sprint_selection).order('scrum_date ASC')

    #render the csv
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"all-scrums.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def edit
    @daily_scrum = DailyScrum.find(params[:id])
  end

  def update
    @daily_scrum = DailyScrum.find(params[:id])

    #If the form is successfully saved, display the saved info. Else, render the error.
    if @daily_scrum.update(daily_scrum_params)
      redirect_to @daily_scrum
    else
      render 'edit'
    end
  end

  def destroy
  end

  #Strong Parameters, new in Rails 4. This whitelists the
  #Acceptable parameters to be passed to the model.
  private
  def daily_scrum_params
    params.require(:daily_scrum).permit(:scrum_date, :sprint_id, :scrum_yesterday, :scrum_today, :scrum_blockers, :scrum_user)
  end

end
