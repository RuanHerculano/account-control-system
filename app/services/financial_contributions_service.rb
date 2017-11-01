require 'securerandom'

class FinancialContributionsService
  def create(financial_contribution_params)
    success = false
    status = :unprocessable_entity

    financial_contribution = FinancialContribution.new(
      value: financial_contribution_params[:value],
      account_id: financial_contribution_params[:account_id],
      code: generate_unique_code
    )

    if financial_contribution.save
      success = true
      status = :created
    end

     ResultResponseService.new(success, status, financial_contribution)
  end

  def self.generate_unique_code
    code = nil

    begin
      code = SecureRandom.uuid
      valid_code = FinancialContribution.find_by(code: code)
    end while(!valid_code.blank?)

    code
  end
  private_class_method :generate_unique_code
end
