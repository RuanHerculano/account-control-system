class AccountsController < ApplicationController
  # GET /corporate_entities
  def index
    result = AccountsService.index

    render json: result
  end

  # GET /corporate_entities/1
  def show
    result = AccountsService.show(params[:id])

    render json: result
  end

  # POST /corporate_entities
  def create
    result = AccountsService.create(account_params)

    if result.success
      render json: result.response, status: result.status, location: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  # PATCH/PUT /corporate_entities/1
  def update
    result = AccountsService.update(params[:id], account_params)

    if result.success
      render json: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  # DELETE /corporate_entities/1
  def destroy
    AccountsService.destroy(params[:id])
  end

  private

  # Only allow a trusted parameter "white list" through.
  def account_params
    params.require(:account).permit(:name,
                                    :corporate_entity_id,
                                    :individual_entity_id,
                                    :account_id,
                                    :status)
  end
end
