class CorporateEntitiesController < ApplicationController
  # GET /corporate_entities
  def index
    result = CorporateEntitiesService.index

    render json: result
  end

  # GET /corporate_entities/1
  def show
    result = CorporateEntitiesService.show(params[:id])

    render json: result
  end

  # POST /corporate_entities
  def create
    result = CorporateEntitiesService.create(corporate_entity_params)

    if result.success
      render json: result.response, status: result.status, location: result.response
    else
      render json: result.response.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /corporate_entities/1
  def update
    result = CorporateEntitiesService.update(params[:id], corporate_entity_params)

    if result.success
      render json: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  # DELETE /corporate_entities/1
  def destroy
    CorporateEntitiesService.destroy(params[:id])
  end

  private

  # Only allow a trusted parameter "white list" through.
  def corporate_entity_params
    params.require(:corporate_entity).permit(:cnpj, :business, :trading_name)
  end
end
