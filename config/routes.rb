Rails.application.routes.draw do
  resources :courses
  resources :groups
  resources :students

  post 'courses/oceny'

  root to: "students#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
