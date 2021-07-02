Rails.application.routes.draw do
  get 'clients/:id', to: "clients#show", defaults: {format: :json}
  get 'clients/:id/payments', to: "clients#payments", defaults: {format: :json}
  get 'clients/:id/transactions', to: "clients#transactions", defaults: {format: :json}
end
