class CorporateEntitiesService
  def self.create(corporate_entity_params)
    corporate_entity = CorporateEntity.new(corporate_entity_params)
    success = false
    status = :unprocessable_entity

    if corporate_entity.save
      success = true
      status = :created
    end

    ResultResponseService.new(success, status, corporate_entity)
  end

  def self.update(id, corporate_entity_params)
    corporate_entity = CorporateEntity.find(id)
    success = false
    status = :unprocessable_entity

    if corporate_entity.update(corporate_entity_params)
      success = true
      status = :updated
    end

    ResultResponseService.new(success, status, corporate_entity)
  end

  def self.all
    CorporateEntity.all
  end

  def self.show(id)
    CorporateEntity.find(id)
  end

  private

  def self.valid_cnpj?(cnpj)
    CNPJ.valid?(cnpj)
  end
end
