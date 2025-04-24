Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  
  resources :announcement do
    collection do
      get :myannounce
    end
  end
  
  root "announcement#index"
end