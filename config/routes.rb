Rails.application.routes.draw do
  resources :schools
  resources :invoices do
    post :paymentredirect
  end
  resources :fees do
    post :paymentredirect
  end
  resources :payments
  devise_for :users, :controllers => 
  {:registrations => "users/registrations",
  :sessions => "users/sessions",
  :passwords => 'users/passwords', 
  :confirmations => 'users/confirmations'}

  get "homes", to: "homes#index"

  resources :students
  resources :teachers
  resources :enrollments, only: [:index, :new, :create, :destroy]
  resources :users, only: [:index, :edit, :update, :destroy]

  root to: redirect('users/sign_in')

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
