corporate_entity = CorporateEntity.create(
  cnpj: '60.267.731/0001-20',
  business: 'Tecnologia da informação',
  trading_name: 'AIS Digital'
)

individual_entity = IndividualEntity.create(
  cpf: '04137644195',
  full_name: 'Ruan Herculano',
  date_birth: '18/03/1995'
)

Account.create!(
  value: 0,
  name: 'Conta poupança Caixa Econômica Federal',
  corporate_entity: corporate_entity,
  individual_entity: nil,
  account: nil,
  level: 0,
  status: 'active'
)

Account.create!(
  value: 0,
  name: 'Conta poupança Banco do Brasil',
  corporate_entity: nil,
  individual_entity: individual_entity,
  account: nil,
  level: 0,
  status: 'active'
)
