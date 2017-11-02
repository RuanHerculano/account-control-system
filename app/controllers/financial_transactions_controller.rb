class FinancialTransactionsController < ApplicationController
  def index
    financial_transaction = FinancialTransaction.all

    render json: financial_transaction
  end

  def create
    result = FinancialTransactionsService.create(financial_transaction_params)

    if result.success
      render json: result.response, status: result.status
    else
      render json: result.response.errors, status: result.status
    end
  end

  def reversal
    result = FinancialTransactionsService.reversal(params[:id])

    if result.success
      render json: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  private

  def financial_transaction_params
    params.require(:financial_transaction).permit(:value, :origin_id, :destination_id)
  end
end
