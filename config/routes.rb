Rails.application.routes.draw do
  resources :task_records, only: [:index, :new, :create, :show, :destroy]
  resources :users, only: [:index, :show]
  resources :stats, only: [:index]

  root "task_records#new"
end
