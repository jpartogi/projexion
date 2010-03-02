Projexion::Application.routes.draw do |map|
  resource :main

  resources :users, :except => [:index, :destroy] do
  	member do
  	  get :change_password
  	end
  end
  
  resources :user_sessions
  map.login  '/login',  :controller => "user_sessions", :action => "new"
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end
  #map.settings 'settings', :controller => 'settings'

  match 'projects/:project_id/sprints/taskboard' => 'sprints#taskboard', :as => :taskboard

  match 'projects/:project_id/sprints/burndown' => 'sprints#burndown', :as => :burndown

  resources :projects do
    resources :features do
      resources :tasks, :acceptances

      member do
        post :list
      end
    end

    resources :releases do
      member do
        put :release
      end
    end

    resources :sprints do
      member do
        get :burndown
        get :taskboard
        put :cancel
      end
    end

    resources :meetings do
      member do
        delete :cancel
      end
    end
  end

  namespace :admin do  
  	resources :users  
    resources :task_statuses
    resources :meeting_types  
  end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  #map.root :controller => "main"
  root :to => "main#index"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  match ':controller(/:action(/:id(.:format)))'
  #map.connect ':controller/:action'
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
