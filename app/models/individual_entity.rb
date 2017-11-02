class IndividualEntity < ApplicationRecord
  validates :cpf,        presence: true
  validates :full_name,  presence: true
  validates :date_birth, presence: true

  validate :validate_cpf, :validate_date

  def validate_date
    if Date.today < date_birth
      self.errors.add(:date_birth, 'birthday date can not be greater than current')
    elsif date_birth.year < Date.today.year - 150
      self.errors.add(:date_birth, 'Individual entity can not be more than 150 years old')
    end
  end

  def validate_cpf
    self.errors.add(:cpf, 'invalid cpf') unless CPF.valid?(cpf)
  end
end
