Rails.application.routes.draw do
   resources :announcement
  root "announcement#index"

  
end
