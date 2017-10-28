class IndividualEntitiesController < ApplicationController
  before_action :set_individual_entity, only: [:show, :edit, :update, :destroy]

  # GET /individual_entities
  def index
    @individual_entities = IndividualEntity.all

    render json: @individual_entities
  end

  # GET /individual_entities/1
  def show
    render json: @individual_entity
  end

  # POST /individual_entities
  def create
    @individual_entity = IndividualEntity.new(individual_entity_params)

    if @individual_entity.save
      render json: @individual_entity, status: :created, location: @individual_entity
    else
      render json: @individual_entity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /individual_entities/1
  def update
    if @individual_entity.update(individual_entity_params)
      render json: @individual_entity
    else
      render json: @individual_entity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /individual_entities/1
  def destroy
    @individual_entity.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_individual_entity
    @individual_entity = IndividualEntity.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def individual_entity_params
    params.require(:individual_entity).permit(:cpf, :full_name, :date_birth)
  end
end
