class FinancialTransaction < ApplicationRecord
  include Defaults

  belongs_to :account, class_name: 'Account', foreign_key: 'origin_id'
  belongs_to :account, class_name: 'Account', foreign_key: 'destination_id'

  enum status: [:completed, :reversaled]

  default :status, 'completed'

  def origin
    Account.find(origin_id)
  end

  def destination
    Account.find(destination_id)
  end
end
