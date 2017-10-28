Rails.application.routes.draw do
  resources :individual_entities
  resources :corporate_entities
  resources :accounts
  resources :financial_contributions
  resources :financial_transactions
end
