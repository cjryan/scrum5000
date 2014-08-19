class SprintsController < ApplicationController
  def index
  end
  def new
  end
  def create
    render plain: params[:sprint].inspect
  end
end
