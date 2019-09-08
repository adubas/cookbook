class Api::V1::RecipeTypesController < Api::V1::ApiController
  before_action :authenticate_user!, only: %i[create]

  def show
    @recipe_type = RecipeType.find(params[:id])
    render json: @recipe_type.to_json(include: :recipes), status: :accepted

  rescue ActiveRecord::RecordNotFound
    render json: "Tipo de receita não encontrada", status: :not_found
  end

  def create
    @recipe_type = RecipeType.new(params.require(:recipe_type).permit(:name))
    if @recipe_type.save
      render json: @recipe_type, status: :created
    else
      render json: {msg: 'Não foi possível criar esse tipo de receita', error_type: @recipe_type.errors.full_messages }, status: :precondition_failed
    end
  end
end
