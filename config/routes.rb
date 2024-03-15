Rails.application.routes.draw do
  devise_for :users
  
  resources :students
  resources :teachers
  resources :enrollments, only: [:index, :new, :create, :destroy]

  root to: 'students#index'
end
