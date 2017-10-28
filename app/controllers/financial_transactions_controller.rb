class FinancialTransactionsController < ApplicationController
  before_action :set_financial_transaction, only: [:show, :edit, :update, :destroy]

  # GET /financial_transaction
  def index
    @financial_transaction = FinancialTransaction.all

    render json: @financial_transaction
  end

  # GET /financial_transaction/1
  def show
    render json: @financial_transaction
  end

  # POST /financial_transaction
  def create
    @financial_transaction = FinancialTransaction.new(financial_transaction_params)

    if @financial_transaction.save
      render json: @financial_transaction, status: :created, location: @financial_transaction
    else
      render json: @financial_transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /financial_transaction/1
  def update
    if @financial_transaction.update(financial_transaction_params)
      render json: @financial_transaction
    else
      render json: @financial_transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /financial_transaction/1
  def destroy
    @financial_transaction.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_financial_transaction
    @financial_transaction = FinancialTransaction.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def financial_transaction_params
    params.require(:financial_transaction).permit(:value, :origin_id, :destination_id, :code)
  end
end
