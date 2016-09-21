Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "events#index"

  resources :events do
    collection do
      get :get_more_event
    end
  end

  resources :teams do
    resources :project do
      resources :todos
    end
  end

end
