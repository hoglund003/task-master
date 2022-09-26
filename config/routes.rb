Rails.application.routes.draw do
  resources :task_records, only: [:new]

  root "task_records#new"
end
