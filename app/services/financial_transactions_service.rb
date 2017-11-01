class FinancialTransactionsService
  def self.create(financial_transaction_params)
    success = false
    status = :unprocessable_entity
    financial_transaction = FinancialTransaction.new(financial_transaction_params)
    origin_account = Account.find(financial_transaction.origin_id)

    if origin_account.value > financial_transaction.value
      subtract_origin(origin_account, financial_transaction)
      increment_destination(financial_transaction)
      success = financial_transaction.save
      status = :created if success
    else
      financial_transaction.errors.add(:value, 'origin account has insufficient value for this transaction')
    end

    ResultResponseService.new(success, status, financial_transaction)
  end

  def self.reversal(id)
    success = true
    status = :updated
    financial_transaction = FinancialTransaction.find(id)

    if financial_transaction.status == 'completed'
      update_origin(financial_transaction)
      update_destination(financial_transaction)
      financial_transaction.update(status: 'reversaled')
    else
      success = false
      status = :unprocessable_entity
      financial_transaction.errors.add(:status, 'is impossible to reverse a transaction that is already reversaled')
    end

    ResultResponseService.new(success, status, financial_transaction)
  end

  def self.subtract_origin(origin_account, financial_transaction)
    new_value = origin_account.value + financial_transaction.value
    origin_account.update(value: new_value)
  end
  private_class_method :subtract_origin

  def self.increment_destination(financial_transaction)
    destination_account = Account.find(financial_transaction.destination_id)
    new_value = destination_account.value + financial_transaction.value
    destination_account.update(value: new_value)
  end
  private_class_method :increment_destination

  def self.update_origin(financial_transaction)
    origin_account = Account.find(financial_transaction.origin_id)
    new_value = origin_account.value + financial_transaction.value
    origin_account.update(value: new_value)
  end
  private_class_method :update_origin

  def self.update_destination(financial_transaction)
    destination_account = Account.find(financial_transaction.destination_id)
    new_value = destination_account.value - financial_transaction.value
    destination_account.update(value: new_value)
  end
  private_class_method :update_destination
end
