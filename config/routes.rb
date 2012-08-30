RhodesRor::Application.routes.draw do
  
  get "logout" => "auth_sessions#destroy", :as => "logout"
  get "login" => "auth_sessions#new", :as => "login"
  
  resources :auth_sessions, :only => [:new, :create, :destroy]
  
  resources :materials, :only => [:index, :show, :search] do
    put :search, :to => 'materials#search'
  end
   
  namespace :admin do
    
    match '/' => 'admin#index'
    
    resources :material_types, :finishes, :applications
    
    resources :materials do
      put :update_default_image, :to => 'materials#update_default_image'                                  
      put :update_search_icon_image, :to => 'materials#update_search_icon_image'
      get :default_image_ids, :to => 'materials#default_image_ids'
    end
    
    resources :images, :only => [:create, :destroy] do
      put :update_image_finish_id, :to => 'images#update_finish_id'
      put :update_image_min_thickness, :to => 'images#update_min_thickness'
    end
  end    
 
  match '/materials/search' => 'materials#search'
  
  root :to => 'application#index'

  # a catch all for invalid urls - suggested by radar
  match '*path', :to => "application#bad_route"

end
