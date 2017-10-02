Rails.application.routes.draw do
  resources :schedule_times
  resources :light_logs
  resources :lights
  resources :places
  resources :users

  scope :format => true, :constraints => { :format => 'json' } do
    post   "/login"       => "sessions#create"
    delete "/logout"      => "sessions#destroy"
  end  
end
