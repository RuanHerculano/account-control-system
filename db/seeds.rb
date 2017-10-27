corporate_entity = CorporateEntity.create(cnpj: 'MyString', business: 'MyString', trading_name: 'MyString')

individual_entity = IndividualEntity.create(cpf: 'MyString', full_name: 'MyString', date_birth: '18/03/1995')

Account.create!(
  name: 'MyString',
  corporate_entity: corporate_entity,
  individual_entity: individual_entity,
  account: nil,
  level: 0,
  status: 'active'
)

