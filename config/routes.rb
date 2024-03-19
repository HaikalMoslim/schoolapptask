Rails.application.routes.draw do
  resources :receipts do
    post :paymentredirect, on: :member
  end
  resources :payments
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  
  resources :students
  resources :teachers
  resources :enrollments, only: [:index, :new, :create, :destroy]

  root to: 'students#index'
end
