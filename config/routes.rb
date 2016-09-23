Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "teams#index"



  resources :teams do
    resources :projects do
      resources :todos do
        resources :todo_states, only: [ :new, :edit, :update, :destroy, :create]
        resources :comments
      end
    end

    resources :events
    resources :more_events, only: :index

  end

end
