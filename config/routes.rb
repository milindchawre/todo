Rails.application.routes.draw do
  resources :tasks, except: [:show]
  root "tasks#index"
end

get '/health_check', to: proc { [200, {}, ['success']] }