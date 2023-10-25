Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  resources :vacation_requests
  namespace :admin do
    resources :vacation_requests
  end
  match '*unmatched', to: 'application#not_found_method', via: :all
end
