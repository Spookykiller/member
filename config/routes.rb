Rails.application.routes.draw do
  get 'portfolio/show'

  devise_for :users
  
  #if user is not signed in
  get ':fullname', to: 'portfolio#show', as: :portfolio
  
  resources :users, only: [:show]
  
  resources :posts do 
    member do
      get "like", to: "posts#upvote"
      get "dislike", to: "posts#downvote"
    end
    resources :comments
  end
  
  root 'posts#index'
end
