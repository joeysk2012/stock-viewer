Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'table#index', as: 'home' #go to table controller and get index view

  resources :table, except: :index
  resources :stock

end
