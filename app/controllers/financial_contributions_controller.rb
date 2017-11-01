class FinancialContributionsController < ApplicationController
  def index
    financial_contribution = FinancialContribution.all

    render json: financial_contribution
  end

  def show
    render json: financial_contribution
  end

  def create
    result = FinancialContributionsService.create(financial_contribution_params)

    if result.success
      render json: result.response, status: result.status
    else
      render json: result.response.errors, status: result.status
    end
  end

  def reversal
    result = FinancialContributionsService.reversal(params[:id], financial_contribution_params)

    if result.success
      render json: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  private

  def financial_contribution_params
    params.require(:financial_contribution).permit(:value, :account_id, :code)
  end
end
