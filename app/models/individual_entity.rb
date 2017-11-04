class IndividualEntity < ApplicationRecord
  validates :cpf,        presence: true
  validates :full_name,  presence: true
  validates :date_birth, presence: true

  validate :validate_cpf, :validate_duplicate_cpf

  def validate_duplicate_cpf
    return false unless id.blank?
    self.errors.add(:cpf, 'duplicate cpf') if IndividualEntity.find_by(cpf: cpf)
  end

  def validate_cpf
    self.errors.add(:cpf, 'invalid cpf') unless CPF.valid?(cpf)
  end
end
