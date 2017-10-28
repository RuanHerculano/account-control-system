require 'cpf_cnpj'

class IndividualEntitiesService
  def self.create_individual_entity(individual_entity_params)
    individual_entity = IndividualEntity.new(individual_entity_params)
    success = true
    status = :created

    if valid_cpf?(individual_entity.cpf)
      individual_entity.save
    else
      success = false
      status = :unprocessable_entity
      individual_entity.errors.add(:cpf ,'invalid cpf')
    end

    ResultResponseService.new(success, status, individual_entity)
  end

  private

  def self.valid_cpf?(cpf)
    CPF.valid?(cpf)
  end
end
