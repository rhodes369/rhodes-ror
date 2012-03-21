RhodesRor::Application.routes.draw do
  
  resources :materials, :only => [:index, :show]
   
  namespace :admin do
    resources :finishes, :applications, :images
    resources :materials do
      put :update_default_image, :to => 'materials#update_default_image'
      #match "/about" => "info#about", :as => :about  
      #match '/update_default_image', :as => :update_default_image
      # put '/update_default_image/:default_image_id(.:format)', 
      #   { :controller => 'admin/materials', 
      #     :action => 'update_default_image', 
      #     :as => :update_default_mat_image 
      #   }                                   
    end
  end    
  # resources :materials do
  #   #match ':controller/:action/:id/:user_id'
  #   #match 'update_default_image/:default_image_id' => 'materials#update_default_image', :via => :get
  #   get 'materials/update_default_image', :as => :update_default_mat_image
  # end
  # 

  
  match '/admin' => 'admin/admin#index'
  
  #root :to => 'public/index.haml'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
