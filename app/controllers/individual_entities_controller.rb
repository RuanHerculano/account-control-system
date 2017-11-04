class IndividualEntitiesController < ApplicationController
  def index
    result = IndividualEntitiesService.all

    render json: result
  end

  def show
    result = IndividualEntitiesService.show(params[:id])

    render json: result
  end

  def create
    result = IndividualEntitiesService.create(individual_entity_params)

    if result.success
      render json: result.response, status: result.status, location: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  def update
    result = IndividualEntitiesService.update(params[:id], individual_entity_params)

    if result.success
      render json: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  private

  def individual_entity_params
    params.require(:individual_entity).permit(:cpf, :full_name, :date_birth)
  end
end
