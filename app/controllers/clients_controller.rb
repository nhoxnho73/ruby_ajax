class ClientsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :set_client, only: [:show, :edit, :update, :delete]

  def index
    @clients = []
    @clients = current_user.clients if current_user
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.valid?
      @client.user = current_user
      @client.save
      redirect_to clients_path
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    @client.update(client_params)
    redirect_to client_path(@client)

  end

  def show
    
  end

  def destroy
    @client.destroy
    redirect_to clients_path
  end
  
  private

  def set_client
    @client = current_user.clients.find_by params[:id]
    if @client.nil?
      flash[:error] = "Client not found"
      redirect_to clients_path
    end
  end

  def client_params
    params.require(:client).permit(:name, :email, :phone_number)
  end
end
