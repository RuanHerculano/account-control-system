require 'securerandom'

class FinancialContributionsService
  def self.create(financial_contribution_params)
    financial_contribution_params[:code] = generate_unique_code
    @financial_contribution = FinancialContribution.new(financial_contribution_params)

    managament_contribution
  end

  def self.managament_contribution
    success = false
    status = :unprocessable_entity
    success = @financial_contribution.save
    status = :created if success
    set_origin
    increment_origin

    ResultResponseService.new(success, status, @financial_contribution)
  end

  def self.reversal(id, financial_contribution_params)
    @financial_contribution = FinancialContribution.find(id)
    validate_status
    validate_code(financial_contribution_params[:code])

    unless @financial_contribution.errors.messages.blank?
      return ResultResponseService.new(false, :unprocessable_entity, @financial_contribution)
    end

    reverval_financial_contribution
  end

  def self.set_origin
    begin
      @origin = Account.find(@financial_contribution.account_id)
    rescue ActiveRecord::RecordNotFound => error
      @financial_transaction.errors.add(:account_id, error.message)
    end
  end
  private_class_method :set_origin

  def self.validate_status
    if @financial_contribution.status == 'reversaled'
      @financial_contribution.errors.add(:code, 'this reversal already been reversed')
    end
  end

  def self.validate_code(code)
    if @financial_contribution.code != code
      financial_contribution.errors.add(:code, 'invalid code')
    end
  end

  def self.reverval_financial_contribution
    success = false
    status = :unprocessable_entity
    success = @financial_contribution.update(status: 'reversaled')
    status = :update if success
    set_origin
    subtract_destination
    ResultResponseService.new(success, status, @financial_contribution)
  end

  def self.increment_origin
    new_value = @origin.value + @financial_contribution.value
    @origin.update(value: new_value)
  end
  private_class_method :increment_origin

  def self.subtract_destination
    new_value = @origin.value - @financial_contribution.value
    @origin.update(value: new_value)
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
