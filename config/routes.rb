Rails.application.routes.draw do
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
  get 'places/:id/lights', to: 'places#show_lights', as: :places_show_lights
  get 'lights/:id/light_logs', to: 'lights#show_light_logs', as: :lights_show_light_logs
  get 'lights/:id/data', to: 'lights#graph_data', as: :light_graph_data

end
