require 'securerandom'

class FinancialContributionsService
  def self.create(financial_contribution_params)
    success = false
    status = :unprocessable_entity

    financial_contribution = FinancialContribution.new(
      value: financial_contribution_params[:value],
      account_id: financial_contribution_params[:account_id],
      code: generate_unique_code,
      status: 'completed'
    )

    if financial_contribution.save
      account = Account.find(financial_contribution.account_id)
      account.update(value: financial_contribution.value)
      success = true
      status = :created
    end

    ResultResponseService.new(success, status, financial_contribution)
  end

  def self.reversal(id, financial_contribution_params)
    financial_contribution = FinancialContribution.find(id)
    result = validate_status(financial_contribution)
    return result unless result.success

    result = validate_code(financial_contribution)
    return result unless result.success

    code = financial_contribution_params[:code]
    reverval_financial_contribution(financial_contribution, code)
  end

  def self.validate_status(financial_contribution)
    if financial_contribution.status == 'reversaled'
      financial_contribution.errors.add(:code, 'this reversal already been reversed')
      return ResultResponseService.new(false, :unprocessable_entity, financial_contribution)
    end

    ResultResponseService.new(true, nil, nil)
  end

  def self.validate_code(financial_contribution, code)
    if financial_contribution.code != code
      financial_contribution.errors.add(:code, 'invalid code')
      return ResultResponseService.new(false, :unprocessable_entity, financial_contribution)
    end

    ResultResponseService.new(true, nil, nil)
  end

  def self.reverval_financial_contribution(financial_contribution)
    financial_contribution.update(status: 'reversaled')
    subtract_destination(financial_contribution)
    ResultResponseService.new(true, :updated, financial_contribution)
  end

  def self.subtract_destination(financial_transaction)
    destination_account = Account.find(financial_transaction.account_id)
    new_value = destination_account.value - financial_transaction.value
    destination_account.update(value: new_value)
  end
  private_class_method :subtract_destination

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
