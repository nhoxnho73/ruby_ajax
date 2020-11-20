class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params, only: [:show]
  
  def index
    @rooms = Room.all
  end

  def new 
    @room = current_user.rooms.new
  end

  def show
    @messages = @room.messages.includes(:user).order(create_at: :asc)
  end

  def create
    @room = current_user.rooms.new room_params
    if @room.save
      flash[:success] = "Room is create"
      redirect_to rooms_path

    else
      flash.now[:danger]= "Room not create"
      render :new
    end
  end

  private
  def set_params
    @room = Room.find_by id: params[:id]
  end

  def room_params 
    params.require(:room).permit(:name)
  end
end