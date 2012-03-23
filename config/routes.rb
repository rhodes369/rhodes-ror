RhodesRor::Application.routes.draw do
  
  resources :materials, :only => [:index, :show] do
    put :search, :to => 'materials#search'
  end
   
  namespace :admin do
    resources :material_types, :finishes, :applications, :except => 'show'
    resources :materials do
      put :update_default_image, :to => 'materials#update_default_image'                                  
    end
    resources :images do
      put :update_image_finish_id, :to => 'images#update_finish_id'
    end
  end    
 
  match '/admin' => 'admin/admin#index'
  match '/materials/search' => 'materials#search'
  
  #root :to => 'public/index.haml'

end
