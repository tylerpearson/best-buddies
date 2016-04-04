Rails.application.routes.draw do

  get "/process" => "analyzer#process_import"
  get "/processing" => "analyzer#processing"
  get "/results/:username" => "analyzer#results", as: :results
  get "/results/:username/small" => "analyzer#results_small", as: :results_small
  get "/results/:username/image" => "analyzer#results_image", as: :results_image

  get '/auth/:provider/callback' => 'sessions#create'
  get '/get-started' => 'sessions#new', :as => :signin
  get '/sign-out' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  resources :users, only: [:new, :create, :update] do
    collection do
      get '/results_check/:id' => 'users#results_check', :as => :results_check, :defaults => { :format => :json }
    end
  end

  root to: 'home#index'
end
