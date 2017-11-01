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

  def create
    result = FinancialContributionsService.create(financial_contribution_params)

    if result.success
      render json: result.response, status: result.status
    else
      render json: result.response.errors, status: result.status
    end
  end

  # PATCH/PUT /financial_contribution/1
  def reversal
    result = FinancialContributionsService.reversal(params[:id])

    if result.success
      render json: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def financial_contribution_params
    params.require(:financial_contribution).permit(:value, :account_id)
  end
end
