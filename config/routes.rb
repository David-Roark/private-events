Rails.application.routes.draw do
  get '/user/events/:id', to: 'events#user_events'
  resources :events
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'events#index'
end
