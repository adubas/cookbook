class Api::V1::CuisinesController < Api::V1::ApiController
  before_action :authenticate_user!, only: %i[create]

  def show
    @cuisine = Cuisine.find(params[:id])
    render json: @cuisine.to_json(include: :recipes), status: :accepted

  rescue ActiveRecord::RecordNotFound
    render json: "Cozinha não encontrada", status: :not_found
  end

  def create
    @cuisine = Cuisine.new(params.require(:cuisine).permit(:name))
    if @cuisine.save
      render json: @cuisine, status: :created
    else
      render json: {msg: "Não foi possível criar essa cozinha", error_type: @cuisine.errors.full_messages }, status: :precondition_failed
    end
  end
end
