Rails.application.routes.draw do
  resources :task_records, only: [:new, :create]

  root "task_records#new"
end
