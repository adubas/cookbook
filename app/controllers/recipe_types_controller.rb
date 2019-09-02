class RecipeTypesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :authorize_admin, only: %i[new create]

  def show
    @recipe_types = RecipeType.all
  end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)

    if @recipe_type.save
      flash[:notice] = "Tipo de Receita cadastrado com sucesso!"
      redirect_to @recipe_type
    else
      render :new
    end
  end

  private

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end

  def authorize_admin
    redirect_to root_path unless current_user.admin
  end
end
