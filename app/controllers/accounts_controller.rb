class AccountsController < ApplicationController
  def index
    @accounts = AccountsService.all

    render :index
  end

  def show
    result = AccountsService.show(params[:id])

    render json: result
  end

  def create
    result = AccountsService.create(account_params)

    if result.success
      render json: result.response, status: result.status, location: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  def update
    result = AccountsService.update(params[:id], account_params)

    if result.success
      render json: result.response
    else
      render json: result.response.errors, status: result.status
    end
  end

  def destroy
    AccountsService.destroy(params[:id])
  end

  private

  def account_params
    params.require(:account).permit(:name,
                                    :corporate_entity_id,
                                    :individual_entity_id,
                                    :account_id,
                                    :status)
  end
end
