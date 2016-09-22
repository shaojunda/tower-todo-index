Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "teams#index"



  resources :teams do
    resources :projects do
      resources :todos do
        resources :comments
      end
    end

    resources :events do
      collection do
        get :get_more_event
      end
    end

  end

end
