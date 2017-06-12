Rails.application.routes.draw do
  
  root 'static_pages#home'
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users,only: [] do
    collection do 
      get 'my_results'
      get 'all_results'
    end
  	resources :tests,except: [:index,:create] do
      collection do 
        match 'tests', to: 'tests#create_test', via: [:get, :post]
        get 'request_error'
        get 'my_tests'
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
