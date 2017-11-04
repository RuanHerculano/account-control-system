class CorporateEntitiesController < ApplicationController
  def index
    result = CorporateEntitiesService.index

    render json: result
  end

  def show
    result = CorporateEntitiesService.show(params[:id])

    render json: result
  end

  def create
    result = CorporateEntitiesService.create(corporate_entity_params)

    if result.success
      render json: result.response, status: result.status, location: result.response
    else
      render json: result.response.errors, status: :unprocessable_entity
    end
  end

  def update
    result = CorporateEntitiesService.update(params[:id], corporate_entity_params)

    if result.success
      render json: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  private

  def corporate_entity_params
    params.require(:corporate_entity).permit(:cnpj, :business, :trading_name)
  end
end
