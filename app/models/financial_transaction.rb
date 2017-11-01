class FinancialTransaction < ApplicationRecord
  belongs_to :account, class_name: 'Account', foreign_key: 'origin_id'
  belongs_to :account, class_name: 'Account', foreign_key: 'destination_id'

  enum status: [:completed, :reversaled]
end
