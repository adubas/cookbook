class RecipeTypesController < ApplicationController
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
end
