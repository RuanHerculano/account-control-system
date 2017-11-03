json.array!(@accounts) do |account|
  json.id account.id
  json.value account.value
  json.name account.name
  json.corporate_entity account.corporate_entity
  json.individual_entity account.individual_entity
  json.account account.account
  json.level account.level
  json.status account.status
end
