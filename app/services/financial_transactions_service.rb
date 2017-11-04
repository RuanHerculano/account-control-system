class FinancialTransactionsService
  def self.create(financial_transaction_params)
    financial_transaction_params[:code] = generate_unique_code
    financial_transaction = FinancialTransaction.new(financial_transaction_params)
    origin_account = Account.find(financial_transaction.origin_id)

    result = validations_transaction(origin_account, financial_transaction)
    unless result.success
      return ResultResponseService.new(result.success, result.status, result.response)
    end

    management_transaction(origin_account, financial_transaction)
  end

  def self.validations_transaction(origin_account, financial_transaction)
    active = check_active_account(origin_account, financial_transaction)
    unless active.success
      return ResultResponseService.new(active.success, active.status, active.response)
    end

    positive = check_positive_balance(origin_account, financial_transaction)
    unless positive.success
      return ResultResponseService.new(positive.success, positive.status, positive.response)
    end

    ResultResponseService.new(true, nil, nil)
  end

  def self.management_transaction(origin_account, financial_transaction)
    success = false
    status = :unprocessable_entity
    subtract_origin(origin_account, financial_transaction)
    increment_destination(financial_transaction)
    success = financial_transaction.save
    status = :created if success

    ResultResponseService.new(success, status, financial_transaction)
  end

  def self.check_active_account(origin_account, financial_transaction)
    if origin_account.status != 'active'
      financial_transaction.errors.add(:status, 'transfers need to be for active accounts')
      return ResultResponseService.new(false, :unprocessable_entity, financial_transaction)
    end

    ResultResponseService.new(true, nil, nil)
  end

  def self.check_positive_balance(origin_account, financial_transaction)
    if origin_account.value < financial_transaction.value
      financial_transaction.errors.add(:value, 'origin account has insufficient value for this transaction')
      return ResultResponseService.new(false, :unprocessable_entity, financial_transaction)
    end

    ResultResponseService.new(true, nil, nil)
  end

  def self.reversal(id)
    success = true
    status = :updated
    financial_transaction = FinancialTransaction.find(id)

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

  def self.subtract_origin(origin_account, financial_transaction)
    new_value = origin_account.value - financial_transaction.value
    origin_account.update(value: new_value)
  end
  private_class_method :subtract_origin

  def self.increment_destination(financial_transaction)
    destination_account = Account.find(financial_transaction.destination_id)
    new_value = destination_account.value + financial_transaction.value
    destination_account.update(value: new_value)
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
