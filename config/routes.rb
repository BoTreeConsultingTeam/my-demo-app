Rails.application.routes.draw do

  resources :cities
  get 'admins/index'

  get 'admins/new'

  get 'admins/show'

  get 'admins/edit'

  devise_for :admins,controllers: {sessions: 'admins/sessions'}
  root 'customers#new'


  resources :cleaners

  post 'customers/logout' => 'customers#logout',as: :logout_customer

  resources :customers

  get 'bookings/get_city_wise_cleaner' => 'bookings#get_city_wise_cleaner',as: :get_city_wise_cleaner
  resources :bookings

  match '*path' => redirect('/404'),via: :get
end
