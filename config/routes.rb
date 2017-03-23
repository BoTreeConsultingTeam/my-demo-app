Rails.application.routes.draw do

  resources :cities
  get 'admins/index'

  get 'admins/new'

  get 'admins/show'

  get 'admins/edit'

  devise_for :admins
  root 'customers#new'


  resources :cleaners

  post 'customers/logout' => 'customers#logout',as: :logout_customer

  resources :customers

  get 'bookings/get_city_wise_cleaner' => 'bookings#get_city_wise_cleaner',as: :get_city_wise_cleaner
  resources :bookings


end
