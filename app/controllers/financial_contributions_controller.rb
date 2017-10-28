class FinancialContributionsController < ApplicationController
  before_action :set_financial_contribution, only: [:show, :edit, :update, :destroy]

  # GET /financial_contribution
  def index
    @financial_contribution = FinancialContribution.all

    render json: @financial_contribution
  end

  # GET /financial_contribution/1
  def show
    render json: @financial_contribution
  end

  # POST /financial_contribution
  def create
    @financial_contribution = FinancialContribution.new(financial_contribution_params)

    if @financial_contribution.save
      render json: @financial_contribution, status: :created, location: @financial_contribution
    else
      render json: @financial_contribution.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /financial_contribution/1
  def update
    if @financial_contribution.update(financial_contribution_params)
      render json: @financial_contribution
    else
      render json: @financial_contribution.errors, status: :unprocessable_entity
    end
  end

  # DELETE /financial_contribution/1
  def destroy
    @financial_contribution.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_financial_contribution
    @financial_contribution = FinancialContribution.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def financial_contribution_params
    params.require(:financial_contribution).permit(:value, :account_id, :code)
  end
end
