json.array!(@financial_contributions) do |financial_contribution|
  json.id          financial_contribution.id
  json.value       financial_contribution.value
  json.account     financial_contribution.account
  json.code        financial_contribution.code
  json.status      financial_contribution.status
end
