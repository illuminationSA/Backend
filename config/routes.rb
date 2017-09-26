Rails.application.routes.draw do
  resources :schedule_times
  resources :light_logs
  resources :lights
  resources :users
  resources :places
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
