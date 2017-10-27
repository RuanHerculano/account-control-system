class Account < ApplicationRecord
  belongs_to :corporate_entity, optional: true
  belongs_to :individual_entity, optional: true
  belongs_to :account, optional: true

  enum status: [:active, :locked, :canceled]
end
