class FinancialTransactionsService
  def self.create(financial_transaction_params)
    financial_transaction_params[:code] = generate_unique_code
    @financial_transaction = FinancialTransaction.new(financial_transaction_params)
    set_origin
    set_destination
    check_active_account
    check_positive_balance

    unless @financial_transaction.errors.messages.blank?
      return ResultResponseService.new(false, :unprocessable_entity, @financial_transaction)
    end

    management_transaction
  end

  def self.reversal(id)
    @financial_transaction = FinancialTransaction.find(id)
    set_origin
    set_destination
    validate_reversal

    unless @financial_transaction.errors.messages.blank?
      return ResultResponseService.new(false, :unprocessable_entity, @financial_transaction)
    end

    management_reversal
  end

  def self.management_transaction
    success = @financial_transaction.save && subtract_origin && increment_destination
    status = :unprocessable_entity
    status = :created if success

    ResultResponseService.new(success, status, @financial_transaction)
  end

  def self.management_reversal
    success = @financial_transaction.update(status: 'reversaled') && increment_origin && subtract_destination
    status = :unprocessable_entity
    status = :updated if success

    ResultResponseService.new(success, status, @financial_transaction)
  end

  def self.check_active_account
    if @origin.status != 'active'
      @financial_transaction.errors.add(:status, 'transfers need to be for active accounts')
    end
  end
  private_class_method :check_active_account

  def self.check_positive_balance
    if @origin.value < @financial_transaction.value
      @financial_transaction.errors.add(:value, 'origin account has insufficient value for this transaction')
    end
  end
  private_class_method :check_positive_balance

  def self.validate_reversal
    if @financial_transaction.status != 'completed'
      @financial_transaction.errors.add(:status, 'is impossible to reverse a transaction that is already reversaled')
    end
  end
  private_class_method :validate_reversal

  def self.set_origin
    begin
      @origin = Account.find(@financial_transaction.origin_id)
    rescue ActiveRecord::RecordNotFound => error
      @financial_transaction.errors.add(:origin_id, error.message)
    end
  end
  private_class_method :set_origin

  def self.set_destination
    begin
      @destination = Account.find(@financial_transaction.destination_id)
    rescue ActiveRecord::RecordNotFound => error
      @financial_transaction.errors.add(:destination_id , error.message)
    end
  end
  private_class_method :set_destination

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

  def self.increment_origin
    new_value = @origin.value + @financial_transaction.value
    @origin.update(value: new_value)
  end
  private_class_method :increment_origin

  def self.subtract_destination
    new_value = @destination.value - @financial_transaction.value
    @destination.update(value: new_value)
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
