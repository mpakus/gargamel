Gargamel::Application.routes.draw do
  
  match '/payments/ok',     :controller => 'payments', :action => 'ok'  
  match '/payments/error',  :controller => 'payments', :action => 'error'
  match '/payments/report', :controller => 'payments', :action => 'report'


  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root :to => "home#index"
  resources :items, :only => [:index, :show]

  match '/category/:id/', :controller => 'items', :action => 'showcategory'  

  resources :category do
    resources :items, :only => [:index, :show]
  end

  authenticated :user do
    # users/items
    namespace :users do
      resources :items do
      end
      resources :items_payments
      resources :payments
    end
  end


  devise_for :users
  resources :users, :only => [:show, :index]

end
