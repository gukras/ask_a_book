Rails.application.routes.draw do
  root 'home#index'
  get 'home/index'
  
  post '/ask', to: 'questions#ask'
  get 'question/:id', to: 'questions#question', as: 'question', constraints: { id: /\d+/ }
  get 'db', to: 'db#index', as: 'db'  

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  devise_for :users

  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
  match '*path', to: 'errors#not_found', via: :all
end
    