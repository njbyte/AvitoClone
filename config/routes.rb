Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
   resources :announcement
  root "announcement#index"

  
end
