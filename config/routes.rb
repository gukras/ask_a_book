Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  
  get "up" => "rails/health#show", as: :rails_health_check

  post '/ask', to: 'questions#ask'
end
