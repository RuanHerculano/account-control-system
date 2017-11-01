class FinancialTransactionsService
  def self.create(financial_transaction_params)
    success = false
    status = :unprocessable_entity
    financial_transaction = FinancialTransaction.new(financial_transaction_params)
    account = Account.find(financial_transaction.origin_id)

    if account.value > financial_transaction.value
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
      financial_transaction.update(status: 'reversaled')
    else
      success = false
      status = :unprocessable_entity
      financial_transaction.errors.add(:status, 'is impossible to reverse a transaction that is already reversaled')
    end

    ResultResponseService.new(success, status, financial_transaction)
  end
end
