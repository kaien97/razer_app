Rails.application.routes.draw do
  get 'help', to: 'static_pages#help'
  get 'about', to: 'static_pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  devise_for :users

  resources :account, param: :id do
    get 'dashboard'
    get 'verify'
    post 'verification'
  end
end
