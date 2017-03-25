Rails.application.routes.draw do
  resources :schedules
  resources :courses
  resources :students
  resources :rooms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index', as: :home

  get '/execute', to: 'schedules#execute', as: :execute
end
