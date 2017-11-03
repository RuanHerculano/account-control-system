class Account < ApplicationRecord
  include Defaults

  belongs_to :corporate_entity, optional: true
  belongs_to :individual_entity, optional: true
  belongs_to :account, optional: true

  enum status: [:active, :locked, :canceled]

  validate :validate_entity_association

  default :status, 0

  default :status, 'active'

  def validate_entity_association
    if corporate_entity_id != nil && individual_entity_id != nil
      self.errors.add(:base, 'account can only have one associated entity')
    elsif corporate_entity_id == nil && individual_entity_id == nil
      self.errors.add(:base, 'account must have one associated entity')
    end
  end
end
