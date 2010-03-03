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
  	resources :users do
      member do
        post :deactivate
      end
    end
      
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
