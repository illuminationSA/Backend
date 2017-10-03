Rails.application.routes.draw do
  resources :schedule_times
  resources :light_logs

  resources :users
  resources :places
  resources :lights

  scope :format => true, :constraints => { :format => 'json' } do
    post   "/login"       => "sessions#create"
    delete "/logout"      => "sessions#destroy"
  end

  get 'users/:id/lights', to: 'users#show_lights', as: :users_show_lights
  get 'users/:id/places', to: 'users#show_places', as: :users_show_places

end
