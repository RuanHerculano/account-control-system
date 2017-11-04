class CorporateEntity < ApplicationRecord
  validates :cnpj,         presence: true
  validates :business,     presence: true
  validates :trading_name, presence: true

  validate :validate_cnpj, :validate_duplicate_cnpj

  def validate_duplicate_cnpj
    return false unless id.blank?
    self.errors.add(:cnpj, 'duplicate cnpj') if CorporateEntity.find_by(cnpj: cnpj)
  end


  def validate_cnpj
    self.errors.add(:cnpj, 'invalid cnpj') unless CNPJ.valid?(cnpj)
  end
end
