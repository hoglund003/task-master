Rails.application.routes.draw do
  get 'static_pages/under_construction', :to => "under_construction#static_pages"
  resources :task_records, only: [:index, :new, :create, :show, :destroy]
  resources :users, only: [:index, :show] do 
    resources :task_records, only: [:index]
  end
  resources :stats, only: [:index]

  scope '/api' do 
    scope '/v1' do 
      post "slack", :to => "slack#slack"
    end
  end

  root "task_records#new"
end
