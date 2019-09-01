class RecipeListsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]

  def show
    @recipe_list = RecipeList.find(params[:id])
  end

  def new
    @recipe_list = RecipeList.new
  end

  def create
    @recipe_list = RecipeList.new(recipe_list_params)
    @recipe_list.user = current_user

    if @recipe_list.save
      flash[:notice] = "Lista criada com sucesso!"
      redirect_to @recipe_list
    else
      render :new
    end
  end

  private

  def recipe_list_params
    params.require(:recipe_list).permit(:name)
  end
end
