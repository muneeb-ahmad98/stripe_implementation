Rails.application.routes.draw do
  resources :products
  root 'products#index'
  post 'checkout/create', to: 'checkout#create'
  get "success", to: "checkout#success"
  get "cancel", to: "checkout#cancel"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
