class Api::V1::RecipesController < Api::V1::ApiController
  before_action :authenticate_user!, only: %i[create update]
  before_action :find_recipe, only: %i[update destroy]

  def show
    @recipe = Recipe.find(params[:id])
    render json: @recipe, status: :accepted
  rescue ActiveRecord::RecordNotFound
    render json: "Receita não encontrada", status: :not_found
  end

  def create
    @recipe = Recipe.create(recipe_params)
    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: { msg: "Não foi possível criar essa receita", error_type: @recipe.errors.full_messages }, status: :precondition_failed
    end
  end

  def update
    if @recipe.owner?(current_user)
      if @recipe.update(recipe_params)
        render json: @recipe, status: :accepted
      else
        render json: { msg: "Não foi possível editar essa receita", error_type: @recipe.errors.full_messages }, status: :precondition_failed
      end
    else
      render json: { msg: "Só o criador da receita pode editá-la" }, status: :precondition_failed
    end
  end

  def destroy
    if @recipe.owner?(current_user)
      @recipe.destroy
      render json: { msg: "Receita apagada com sucesso" }, status: :accepted
    else
      render json: { msg: "Só o criador da receita pode apagá-la" }, status: :precondition_failed
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :ingredients, :cook_method, :user_id, :status)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
end
