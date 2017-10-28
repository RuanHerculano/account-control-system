class CorporateEntitiesController < ApplicationController
  before_action :set_corporate_entity, only: [:show, :edit, :update, :destroy]

  # GET /corporate_entities
  def index
    @corporate_entities = CorporateEntity.all

    render json: @corporate_entities
  end

  # GET /corporate_entities/1
  def show
    render json: @corporate_entity
  end

  # POST /corporate_entities
  def create
    @corporate_entity = CorporateEntity.new(corporate_entity_params)

    if @corporate_entity.save
      render json: @corporate_entity, status: :created, location: @corporate_entity
    else
      render json: @corporate_entity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /corporate_entities/1
  def update
    if @corporate_entity.update(corporate_entity_params)
      render json: @corporate_entity
    else
      render json: @corporate_entity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /corporate_entities/1
  def destroy
    @corporate_entity.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_corporate_entity
    @corporate_entity = CorporateEntity.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def corporate_entity_params
    params.require(:corporate_entity).permit(:cnpj, :business, :trading_name)
  end
end
