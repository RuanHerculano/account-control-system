class AccountsService
  def self.create(account_params)
    success = false
    status = :unprocessable_entity
    account_params = define_level(account_params)
    account = Account.new(account_params)

    if account.save
      success = true
      status = :created
    end

    ResultResponseService.new(success, status, account)
  end

  def self.update(id, account_params)
    success = false
    status = :unprocessable_entity
    account_params = define_level(account_params)
    account = Account.find(id)

    if account.update(account_params)
      success = true
      status = :updated
    end

    ResultResponseService.new(success, status, account)
  end

  def self.all
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
      return account_params
    end

    account = Account.find(account_params[:account_id])
    account_params[:level] = account.level + 1
    account_params
  end
  private_class_method :define_level
end
