class CuisinesController < ApplicationController
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
end
