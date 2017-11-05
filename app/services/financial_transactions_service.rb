class FinancialTransactionsService
  def self.create(financial_transaction_params)
    financial_transaction_params[:code] = generate_unique_code
    @financial_transaction = FinancialTransaction.new(financial_transaction_params)

    begin
      @origin = Account.find(@financial_transaction.origin_id)
      @destination = Account.find(@financial_transaction.destination_id)
    rescue ActiveRecord::RecordNotFound => error
      @financial_transaction.errors.add(:base, error.message)
      return ResultResponseService.new(false, :unprocessable_entity, financial_transaction)
    end

    result = validations_transaction
    unless result.success
      return ResultResponseService.new(result.success, result.status, result.response)
    end

    management_transaction
  end

  def self.validations_transaction
    result = check_active_account
    unless result.success
      return ResultResponseService.new(result.success, result.status, result.response)
    end

    result = check_positive_balance
    unless result.success
      return ResultResponseService.new(result.success, result.status, result.response)
    end

    ResultResponseService.new(true, nil, nil)
  end

  def self.management_transaction
    success = false
    status = :unprocessable_entity
    subtract_origin
    increment_destination
    success = @financial_transaction.save
    status = :created if success

    ResultResponseService.new(success, status, @financial_transaction)
  end

  def self.check_active_account
    if @origin.status != 'active'
      @financial_transaction.errors.add(:status, 'transfers need to be for active accounts')
      return ResultResponseService.new(false, :unprocessable_entity, @financial_transaction)
    end

    ResultResponseService.new(true, nil, nil)
  end

  def self.check_positive_balance
    if @origin.value < @financial_transaction.value
      @financial_transaction.errors.add(:value, 'origin account has insufficient value for this transaction')
      return ResultResponseService.new(false, :unprocessable_entity, @financial_transaction)
    end

    ResultResponseService.new(true, nil, nil)
  end

  def self.reversal(id)
    success = true
    status = :updated
    @financial_transaction = FinancialTransaction.find(id)

    if financial_transaction.status == 'completed'
      increment_origin(financial_transaction)
      subtract_destination(financial_transaction)
      financial_transaction.update(status: 'reversaled')
    else
      success = false
      status = :unprocessable_entity
      financial_transaction.errors.add(:status, 'is impossible to reverse a transaction that is already reversaled')
    end

    ResultResponseService.new(success, status, financial_transaction)
  end

  def self.subtract_origin
    new_value = @origin.value - @financial_transaction.value
    @origin.update(value: new_value)
  end
  private_class_method :subtract_origin

  def self.increment_destination
    new_value = @destination.value + @financial_transaction.value
    @destination.update(value: new_value)
  end
  private_class_method :increment_destination

  def self.increment_origin(financial_transaction)
    origin_account = Account.find(financial_transaction.origin_id)
    new_value = origin_account.value + financial_transaction.value
    origin_account.update(value: new_value)
  end
  private_class_method :increment_origin

  def self.subtract_destination(financial_transaction)
    destination_account = Account.find(financial_transaction.destination_id)
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
