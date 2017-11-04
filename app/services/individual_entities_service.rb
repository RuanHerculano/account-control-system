class IndividualEntitiesService
  def self.create(individual_entity_params)
    individual_entity = IndividualEntity.new(individual_entity_params)
    success = false
    status = :unprocessable_entity

    if individual_entity.save
      success = true
      status = :created
    end

    ResultResponseService.new(success, status, individual_entity)
  end

  def self.update(id, individual_entity_params)
    individual_entity = IndividualEntity.find(id)
    success = false
    status = :unprocessable_entity

    if individual_entity.update(individual_entity_params)
      success = true
      status = :updated
    end

    ResultResponseService.new(success, status, individual_entity)
  end

  def self.all
    IndividualEntity.all
  end

  def self.show(id)
    IndividualEntity.find(id)
  end

  private

  def self.valid_cpf?(cpf)
    CPF.valid?(cpf)
  end
end
