class SprintsController < ApplicationController
  def index
  end
  def new
  end
  def create
    @sprint = Sprint.new(sprint_params)

    @sprint.save
    redirect_to @sprint
  end
  def show
    @sprint = Sprint.find(params[:id])
  end

  #Strong Parameters, new in Rails 4. This whitelists the
  #Acceptable parameters to be passed to the model.
  private
  def sprint_params
    params.require(:sprint).permit(:sprint_number, :sprint_description)
  end

end
