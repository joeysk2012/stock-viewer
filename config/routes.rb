Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'table#index', as: 'home' #go to table controller and get index view
  get 'stock/renew_all', to: 'stock#renew_all', via: :get
  get 'stock/suggest_buy_low', to: 'stock#suggest_buy_low', via: :get
  get'about', to: 'pages#about', as: 'about'
  get'contact', to: 'pages#contact', as: 'contact'
  get'suggestion1', to: 'pages#suggestion1', as: 'suggestion1'
  get'suggestion2', to: 'pages#suggestion2', as: 'suggestion2'
  get'machine_learning', to: 'pages#machine_learning', as: 'machine_learning'
  resources :table, except: :index
  resources :stock

end
