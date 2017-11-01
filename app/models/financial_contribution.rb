class FinancialContribution < ApplicationRecord
  belongs_to :account

  enum status: [:completed, :reversaled]
end
