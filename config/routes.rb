Rails.application.routes.draw do

  devise_for :users
  get "/faq" => "pages#faq"
  resources :events

  namespace :admin do
    root "events#index"
    resources :events
  end

  resource :user

  root "events#index"

end
