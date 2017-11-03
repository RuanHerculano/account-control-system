corporate_entity = CorporateEntity.create(cnpj: '04137644195', business: 'MyString', trading_name: 'MyString')

individual_entity = IndividualEntity.create(cpf: '76604380181', full_name: 'MyString', date_birth: '18/03/1995')

Account.create!(
  value: 0,
  name: 'MyString',
  corporate_entity: corporate_entity,
  individual_entity: nil,
  account: nil,
  level: 0,
  status: 'active'
)

Account.create!(
  value: 0,
  name: 'MyString',
  corporate_entity: nil,
  individual_entity: individual_entity,
  account: nil,
  level: 0,
  status: 'active'
)
