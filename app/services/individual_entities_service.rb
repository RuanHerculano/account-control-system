require 'cpf_cnpj'

class IndividualEntitiesService
  def self.create(individual_entity_params)
    individual_entity = IndividualEntity.new(individual_entity_params)
    success = false
    status = :unprocessable_entity

    if valid_cpf?(individual_entity.cpf)
      success = individual_entity.save
      status = :created if success
    else
      individual_entity.errors.add(:cpf, 'invalid cpf')
    end

    ResultResponseService.new(success, status, individual_entity)
  end

  def self.update(id, individual_entity_params)
    individual_entity = IndividualEntity.find(id)
    success = false
    status = :unprocessable_entity

    if valid_cpf?(individual_entity_params[:cpf])
      success = individual_entity.update(individual_entity_params)
      status = :updated if success
    else
      individual_entity.errors.add(:cpf, 'invalid cpf')
    end

    ResultResponseService.new(success, status, individual_entity)
  end

  def self.index
    IndividualEntity.all
  end

  def self.show(id)
    IndividualEntity.find(id)
  end

  def destroy(id)
    individual_entity = IndividualEntity.find(id)
    individual_entity.destroy
  end

  private

  def self.valid_cpf?(cpf)
    CPF.valid?(cpf)
  end
end
