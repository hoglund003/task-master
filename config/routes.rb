Rails.application.routes.draw do
  resources :task_records, only: [:index, :new, :create]

  root "task_records#new"
end
