class AccountsService
  def self.create(account_params)
    success = false
    status = :unprocessable_entity
    account_params = define_level(account_params)
    account = Account.new(account_params)
    corporate_entity_id = account.corporate_entity_id
    individual_entity_id = account.individual_entity_id
    account = validate_entity_association(account,
                                          corporate_entity_id,
                                          individual_entity_id)

    if account.errors.messages.blank?
      success = account.save
      status = :created if success
    end

    ResultResponseService.new(success, status, account)
  end

  def self.update(id, account_params)
    success = false
    status = :unprocessable_entity
    account_params = define_level(account_params)
    account = Account.find(id)
    corporate_entity_id = account_params[:corporate_entity_id]
    individual_entity_id = account_params[:individual_entity_id]
    account = validate_entity_association(account,
                                          corporate_entity_id,
                                          individual_entity_id)

    if account.errors.messages.blank?
      success = account.update(account_params)
      status = :updated if success
    end

    ResultResponseService.new(success, status, account)
  end

  def self.index
    Account.all
  end

  def self.show(id)
    Account.find(id)
  end

  def self.destroy(id)
    account = Account.find(id)
    account.destroy
  end

  def self.define_level(account_params)
    unless account_params[:account_id]
      account_params[:level] = 0
      return account_params;
    end

    account = Account.find(account_params[:account_id])
    account_params[:level] = account.level + 1
    account_params
  end

  def self.validate_entity_association(account, corporate_entity_id, individual_entity_id)
    account = validate_double_association(account, corporate_entity_id, individual_entity_id)
    return account unless account.errors.messages.blank?

    account = validate_nil_association(account, corporate_entity_id, individual_entity_id)
    account
  end

  def self.validate_double_association(account, corporate_entity_id, individual_entity_id)
    if corporate_entity_id != nil && individual_entity_id != nil
      message = 'account can only have one associated entity'
      account = account_add_errors(account, :corporate_entity_id, message)
      account = account_add_errors(account, :individual_entity_id, message)
    end

    account
  end

  def self.validate_nil_association(account, corporate_entity_id, individual_entity_id)
    if corporate_entity_id == nil && individual_entity_id == nil
      message = 'account must have one associated entity'
      account = account_add_errors(account, :corporate_entity_id, message)
      account = account_add_errors(account, :individual_entity_id, message)
    end

    account
  end

  private

  def self.account_add_errors(object, attribute, message)
    object.errors.add(attribute, message)
    object
  end
end
