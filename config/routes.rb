Rails.application.routes.draw do
  resources :individual_entities
  resources :corporate_entities
  resources :accounts
  resources :financial_contributions

  post '/financial_transactions'     => 'financial_transactions#create'
  put  '/financial_transactions/:id' => 'financial_transactions#reversal'
end
