class CuisinesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :authorize_admin, only: %i[new create]

  def show
    @cuisines = Cuisine.all
  end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    
    if @cuisine.save
      flash[:notice] = "Tipo de Cozinha cadastrado com sucesso!"
      redirect_to @cuisine
    else
      render :new
    end
  end

  private

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

  def authorize_admin
    redirect_to root_path unless current_user.admin
  end
end
