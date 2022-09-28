Rails.application.routes.draw do
  resources :task_records, only: [:index, :new, :create, :show]
  resources :users, only: [:index, :show]

  root "task_records#new"
end
