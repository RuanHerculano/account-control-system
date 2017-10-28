class IndividualEntitiesController < ApplicationController
  # GET /individual_entities
  def index
    result = IndividualEntitiesService.index

    render json: result
  end

  # GET /individual_entities/1
  def show
    result = IndividualEntitiesService.show(params[:id])

    render json: result
  end

  # POST /individual_entities
  def create
    result = IndividualEntitiesService.create(individual_entity_params)

    if result.success
      render json: result.response, status: result.status, location: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  # PATCH/PUT /individual_entities/1
  def update
    result = IndividualEntitiesService.update(params[:id], individual_entity_params)

    if result.success
      render json: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  # DELETE /individual_entities/1
  def destroy
    IndividualEntitiesService.destroy(params[:id])
  end

  private

  # Only allow a trusted parameter "white list" through.
  def individual_entity_params
    params.require(:individual_entity).permit(:cpf, :full_name, :date_birth)
  end
end
