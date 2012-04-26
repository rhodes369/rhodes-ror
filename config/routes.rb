RhodesRor::Application.routes.draw do
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  
  resources :users, :only => [:new, :create]
  resources :sessions, :only => [:new, :create, :destroy]
  
  resources :materials, :only => [:index, :show] do
    put :search, :to => 'materials#search'
  end
   
  namespace :admin do
    
    match '/' => 'admin#index'
    
    resources :material_types, :finishes, :applications, :except => 'show'
    
    resources :materials do
      put :update_default_image, :to => 'materials#update_default_image'                                  
    end
    
    resources :images, :only => [:create, :destroy] do
      put :update_image_finish_id, :to => 'images#update_finish_id'
    end
  end    
 
  match '/materials/search' => 'materials#search'
  
  root :to => 'application#index'

  # a catch all for invalid urls - suggested by radar
  match '*path', :to => "application#bad_route"

end
