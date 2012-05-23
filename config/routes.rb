Gargamel::Application.routes.draw do
  root :to => "home#index"

  resources :items, :only => [:index, :show]

  authenticated :user do
    # users/items
    namespace :users do
      resources :items do
      end
    end
  end


  devise_for :users
  resources :users, :only => [:show, :index]

end
