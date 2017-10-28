class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /corporate_entities
  def index
    @corporate_entities = Account.all

    render json: @corporate_entities
  end

  # GET /corporate_entities/1
  def show
    render json: @account
  end

  # POST /corporate_entities
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created, location: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /corporate_entities/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /corporate_entities/1
  def destroy
    @account.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def account_params
    params.require(:account).permit(:name,
                                    :corporate_entity_id,
                                    :individual_entity_id,
                                    :account,
                                    :level,
                                    :status)
  end
end
