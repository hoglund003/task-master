Rails.application.routes.draw do
  resources :task_records, only: [:index, :new, :create]
  resources :users, only: [:index]

  root "task_records#new"
end
