class DestinationsController < ApplicationController
  def index
    @destinations = Destination.where("user_id = ?", params[:user_id])
  end

  def show
    @destination = Destination.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @destination = @user.destinations.build
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @destination = @user.destinations.build(destination_params)

    if @destination.save
      redirect_to user_destinations_path(@user)
    else
      render 'new'
    end
  end

  def update
    @destination = Destination.find(params[:id])

    if @destination.update(destination_params)
      redirect_to @destination
    else
      render 'edit'
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @destination.destroy

    redirect_to destinations_path
  end

  private
  def destination_params
    params.require(:destination).permit(:lat, :long)
  end
end
