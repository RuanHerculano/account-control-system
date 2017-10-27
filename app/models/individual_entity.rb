class IndividualEntity < ApplicationRecord
  validates :cpf,        presence: true
  validates :full_name,  presence: true
  validates :date_birth, presence: true
end
