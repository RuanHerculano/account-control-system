class FinancialTransaction < ApplicationRecord
  belongs_to :account, className: 'Account', foreign_key: 'origin_id'
  belongs_to :account, className: 'Account', foreign_key: 'destination_id'
end
