Rails.application.routes.draw do
  devise_for :users
  resources :profiles, only: [:edit, :update]
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale
  root 'planets_dignities#new'
  get '/planets_dignities/', to: 'planets_dignities#show'
end
