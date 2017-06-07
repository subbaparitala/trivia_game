Rails.application.routes.draw do
  
  root 'static_pages#home'
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users,only: [] do
  	resources :tests
  	resources :questions do
  	   collection do
          get 'questions'
       end
      resources :answers
  	end
  end
end
