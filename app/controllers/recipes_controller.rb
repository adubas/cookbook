class RecipesController < ApplicationController

  before_action :find_recipe, only: %i[show edit update]
  before_action :load_recipe_types, only: %i[new create edit]
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @recipes = Recipe.all
  end

  def show

  end
  
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    
    if @recipe.save
      flash[:notice] = 'Receita salva com sucesso!'
      redirect_to @recipe
    else
      load_recipe_types
      flash.now[:notice] = 'Não foi possível salvar a receita'
      render :new
    end
  end

  def edit
  
  end

  def update

    if @recipe.update(recipe_params)
      flash[:notice] = 'Receita atualizada com sucesso!'
      redirect_to @recipe
    else
      load_recipe_types
      flash.now[:error] = 'Não foi possível salvar a receita'
      render :edit
    end
  end

  def search
    @recipes = Recipe.where('title LIKE ?', "%#{params[:search_recipe]}%")

    if @recipes.empty?
      flash.now[:error] = 'Não há nenhuma receita com esse nome'
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :ingredients, :cook_method)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def load_recipe_types
    @recipe_types = RecipeType.all
  end

end
