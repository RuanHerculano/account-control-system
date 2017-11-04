require 'cpf_cnpj'

class CorporateEntity < ApplicationRecord
  validates :cnpj,         presence: true
  validates :business,     presence: true
  validates :trading_name, presence: true

  validate :validate_cnpj

  def validate_cnpj
    self.errors.add(:cnpj, 'invalid cnpj') unless CNPJ.valid?(cnpj)
  end
end
