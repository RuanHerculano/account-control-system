Rails.application.routes.draw do
  resources :individual_entities
  resources :corporate_entities
  resources :accounts

  get  '/financial_transactions'     => 'financial_transactions#index'
  post '/financial_transactions'     => 'financial_transactions#create'
  put  '/financial_transactions/:id' => 'financial_transactions#reversal'

  get  '/financial_contributions'     => 'financial_contributions#index'
  post '/financial_contributions'     => 'financial_contributions#create'
  put  '/financial_contributions/:id' => 'financial_contributions#reversal'
end
