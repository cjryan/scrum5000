class SprintsController < ApplicationController
  def index
  end
  def new
    #This is present to prevent 'nil' errors when the form is loaded on the 'new' action
    @sprint = Sprint.new
  end
  def create
    @sprint = Sprint.new(sprint_params)

    #If the form is successfully saved, display the saved info. Else, render the error.
    if @sprint.save
      redirect_to @sprint
    else
      render 'new'
    end
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
