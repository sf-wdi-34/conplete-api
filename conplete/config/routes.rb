Rails.application.routes.draw do
  resources :talks
  resources :conferences, defaults: {format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
