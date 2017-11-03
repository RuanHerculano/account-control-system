class FinancialContribution < ApplicationRecord
  include Defaults

  belongs_to :account

  enum status: [:completed, :reversaled]

  default :status, 'completed'
end
