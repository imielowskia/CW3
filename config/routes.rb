Rails.application.routes.draw do

  get 'courses/az' , as: :course_az
  get 'courses/za' , as: :course_za

  get 'courses/:id/list' => 'courses#list', as: :course_list
  get 'courses/:id/remove/:student_id' => 'courses#remove', as: :course_remove
  get 'courses/:id/append/:student_id' => 'courses#append', as: :course_append


  resources :courses
  resources :groups
  resources :students

  post 'courses/oceny'


  root to: "students#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
