Rails.application.routes.draw do
  get 'maps/home'
  resources :schools
  resources :invoices do
    post :paymentredirect
  end
  resources :fees do
    post :paymentredirect
  end
  resources :payments
  devise_for :users, :controllers => {:registrations => "users/registrations",:sessions => "users/sessions"}
  
  resources :students
  resources :teachers
  resources :enrollments, only: [:index, :new, :create, :destroy]

  root to: redirect('/users/sign_in') 
end
