Rails.application.routes.draw do
  root to:'home#top'
  get 'home/top'
  get 'home/about'
  get 'search' => "search#search"
  devise_for :users
    resources :books do
    resources :comments, only:[:create, :destroy]
  	resource :favorites, only:[:create, :destroy]
  end
  resources :users do
    member do
     get :following, :follower
    end
  end
 resources :relationships, only: [:create, :destroy]

  # root 'post_images#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
