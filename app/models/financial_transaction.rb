class FinancialTransaction < ApplicationRecord
  belongs_to :origin_account, className: 'Account', foreign_key: 'account_id'
  belongs_to :destination_account, className: 'Account', foreign_key: 'account_id'
end
