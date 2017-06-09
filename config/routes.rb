Rails.application.routes.draw do
  
  root 'static_pages#home'
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users,only: [] do
  	resources :tests do
      collection do 
        match 'tests', to: 'tests#create', via: [:get, :post]
        get 'request_error'
      end
      member do 
        get 'complete'
      end
    end
  	resources :questions  do
  	   collection do
          get 'questions'
       end
      resources :answers
      member {post :vote }
  	end
  end
end
