class RecipesController < ApplicationController
  before_action :find_recipe, only: %i[show edit update approves rejects]
  before_action :load_attributes, only: %i[new edit]
  before_action :authenticate_user!, only: %i[new create edit update]
  before_action :authorize_admin, only: %i[approves rejects pending]

  def index
    @recipes = Recipe.approved
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
      flash[:notice] = "Receita salva com sucesso!"
      redirect_to @recipe
    else
      load_attributes
      flash.now[:notice] = "Não foi possível salvar a receita"
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:notice] = "Receita atualizada com sucesso!"
      redirect_to @recipe
    else
      load_attributes
      flash.now[:error] = "Não foi possível salvar a receita"
      render :edit
    end
  end

  def add_to_list
    @recipe = Recipe.find(params[:id])
    @recipe_list = RecipeList.find(params[:recipe_list_id])
    @recipe_list_item = RecipeListItem.create(recipe: @recipe, recipe_list: @recipe_list)
    flash[:notice] = "Receita adicionada com sucesso!"
    redirect_to @recipe_list
  end

  def search
    @recipes = Recipe.where("title LIKE ?", "%#{params[:search_recipe]}%")

    if @recipes.empty?
      flash.now[:error] = "Não há nenhuma receita com esse nome"
    end
  end

  def pending
    @recipes = Recipe.pending
  end

  def approves
    @recipe.approved!
    redirect_to @recipe
  end

  def rejects
    @recipe.rejected!
    redirect_to @recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :cook_method, images:[])
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def load_attributes
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def authorize_admin
    redirect_to root_path unless current_user.admin
  end
end
