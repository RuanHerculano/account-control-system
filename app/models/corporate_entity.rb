class CorporateEntity < ApplicationRecord
  validates :cnpj,         presence: true
  validates :business,     presence: true
  validates :trading_name, presence: true
end
