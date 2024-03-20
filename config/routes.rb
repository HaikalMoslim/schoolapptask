Rails.application.routes.draw do
  resources :fees do
  post :paymentredirect
end
  resources :receipts do
    post :paymentredirect
  end
  resources :payments
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  
  resources :students
  resources :teachers
  resources :enrollments, only: [:index, :new, :create, :destroy]

  root to: redirect('/users/sign_in') 
end
