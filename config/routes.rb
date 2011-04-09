Projexion::Application.routes.draw do

  constraints(Subdomain) do
    devise_for :users, :controllers => { :sessions => 'users/sessions',
                                       :registrations => 'users/registrations',
                                       :passwords => 'users/passwords',
                                       :confirmations => 'users/confirmations'}

    root :to => redirect("/users/sign_in")

    resources :priorities

    match 'admin' => 'admin#index', :as => 'admin'
    match 'projects/:project_id/sprints/taskboard' => 'sprints#taskboard', :as => :taskboard

    match 'projects/:project_id/sprints/burndown' => 'sprints#burndown', :as => :burndown_sprint # For ajax

    match 'projects/:project_id/releases/burndown' => 'releases#burndown', :as => :burndown_release # For ajax

    namespace :user do
      root :to => "main#index"
    end
    
    resources :projects do
      resources :features do
        resources :tasks do
          member do
            get :check
          end
        end

        resources :acceptances do
          member do
            get :check
          end
        end

        member do
          post :list
        end
      end

      resources :releases do
        member do
          put :release
          get :burndown
          get :notes
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

      resources :project_members
    end

    namespace :admin do
      resources :users do
        member do
          get :project
          put	:activate
          delete :deactivate
        end

        collection do
          post :project
        end
      end

      resources :priorities
      resources :projects do
        member do
          get :add_user
          put :save_user
        end
      end
      resources :project_roles
      resources :project_members
      resources :feature_statuses
      resources :task_statuses
      resources :meeting_types
    end

    resources :project_roles do
      member do
        get :get_options
      end
    end

    resources :users, :except => [:index,  :destroy] do
      member do
        get :change_password
        put :update_password
      end
    end
  end
  
  resources :accounts

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.

    root :to => "users/sessions#show"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  match ':controller(/:action(/:id(.:format)))'
  #map.connect ':controller/:action'
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
