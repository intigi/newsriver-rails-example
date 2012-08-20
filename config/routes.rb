Newsriver::Application.routes.draw do
  resources :rivers do
    resources :recommendations do
      put 'hide'
      put 'toggle_star'
    end
    member do
      get 'work'
      get 'starred'
    end
  end

  root :to => 'home#index'
end
