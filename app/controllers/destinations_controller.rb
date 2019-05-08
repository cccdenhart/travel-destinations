class DestinationsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
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

    respond_to do |format|
      if @destination.save
        format.html { redirect_to @user_destination, notice: "Save process completed!" }
        format.json { render json: @destination, status: :created, location: @destination }
      else
        format.html {
          flash.now[:notice]="Save proccess coudn't be completed!"
          render :new
        }
        format.json { render json: @destination.errors, status: :unprocessable_entity}
      end
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
    if params.include?("destination")
      permit = ["lat", "long"]
      search = params["destination"]
      destination_params = {}
      permit.each { |p| destination_params.store(p.to_sym, search[p]) if search.include?(p) }
      return destination_params
    else
      return {}
    end
  end
end
