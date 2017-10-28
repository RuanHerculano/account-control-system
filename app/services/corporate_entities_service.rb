require 'cpf_cnpj'

class CorporateEntitiesService
  def self.create(corporate_entity_params)
    corporate_entity = CorporateEntity.new(corporate_entity_params)
    success = false
    status = :unprocessable_entity

    if valid_cnpj?(corporate_entity.cnpj)
      success = corporate_entity.save
      status = :created if success
    else
      corporate_entity.errors.add(:cpf, 'invalid cnpj')
    end

    ResultResponseService.new(success, status, corporate_entity)
  end

  def self.update(id, corporate_entity_params)
    corporate_entity = CorporateEntity.find(id)
    success = false
    status = :unprocessable_entity

    if valid_cnpj?(corporate_entity_params[:cnpj])
      success = corporate_entity.update(corporate_entity_params)
      status = :updated if success
    else
      corporate_entity.errors.add(:cnpj, 'invalid cnpj')
    end

    ResultResponseService.new(success, status, corporate_entity)
  end

  def self.index
    CorporateEntity.all
  end

  def self.show(id)
    CorporateEntity.find(id)
  end

  def self.destroy(id)
    corporate_entity = CorporateEntity.find(id)
    corporate_entity.destroy
  end

  private

  def self.valid_cnpj?(cnpj)
    CNPJ.valid?(cnpj)
  end
end
