Rails.application.routes.draw do
  resources :invoices do
    post :paymentredirect
  end
  resources :fees do
    post :paymentredirect
  end
  resources :payments
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  
  resources :students
  resources :teachers
  resources :enrollments, only: [:index, :new, :create, :destroy]

  root to: redirect('/users/sign_in') 
end
