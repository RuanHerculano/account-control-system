require 'securerandom'

class FinancialContributionsService
  def self.create(financial_contribution_params)
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

  def self.reversal(id, financial_contribution_params)
    code = financial_contribution_params[:code]
    financial_contribution = FinancialContribution.find(id)

    result_response = valid_status(financial_contribution)
    return result_response unless result_response.status

    reverval_financial_contribution(financial_contribution, code)
  end

  def self.validate_status(financial_contribution)
    if financial_contribution.status == 'reversaled'
      financial_contribution.errors.add(:code, 'this reversal already been reversed ')
      return ResultResponseService.new(false, :unprocessable_entity, financial_contribution)
    end

    ResultResponseService.new(true, nil, nil)
  end

  def self.reverval_financial_contribution(financial_contribution, code)
    unless financial_contribution.code == code
      financial_contribution.errors.add(:code, 'invalid code')
      return ResultResponseService.new(success, status, financial_contribution)
    end

    financial_contribution.update(status: 'reversaled')
    ResultResponseService.new(true, :updated, financial_contribution)
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
