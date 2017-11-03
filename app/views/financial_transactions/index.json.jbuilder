json.array!(@financial_transactions) do |financial_transaction|
  json.id          financial_transaction.id
  json.code        financial_transaction.code
  json.value       financial_transaction.value
  json.origin      financial_transaction.origin
  json.destination financial_transaction.destination
  json.status      financial_transaction.status
end
