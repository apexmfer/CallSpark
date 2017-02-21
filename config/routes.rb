Testlog::Application.routes.draw do

	#Casein routes
	namespace :casein do
		resources :bi_vendors
		resources :bi_customers
		resources :bi_orders
		resources :users
	end



 resources :article
 resources :comment
   resources :checkouts



	 get '/projects/export' => 'projects#export', :as => :projects_export



resources :password_resets
resources :projects

resources :user_sessions
resources :users

get '/calls/data' => 'calls#data'
get '/customer/data' => 'customer#data'
get '/company/data' => 'company#data'

  resources :demo_inventory
 resources :company
  resources :customer
  resources :calls

resources :category
resources :category_hint
resources :supportlink
resources :region

  get '/favorite_company_index' =>  'favorite_company#index', :as => :favorite_company_index

  post "/favorite_company" => 'favorite_company#create', :as => :add_company_to_favorites
  post "/unfavorite_company" =>  'favorite_company#destroy', :as => :remove_company_from_favorites

	post "/project_assignment" => 'project_assignment#create', :as => :project_assignment
	post "/project_assignment_remove"=> 'project_assignment#destroy', :as => :project_assignment_remove

	post "/comment_remove"=> 'comment#destroy', :as => :comment_remove


  get "user_sessions/new"

  get "user_sessions/create"

  get "user_sessions/destroy"

  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  get 'customer' => 'customer#index'
  get 'customer/update' => 'customer#update'
  get 'customer/destroy' => 'customer#destroy'
  get 'region/destroy' => 'region#destroy'

  get '/supportcenter' => 'welcome#index'
  get '/checkout/new' => 'checkout#new'
  get '/checkout/return' => 'checkout#return'
  get '/checkout/edit' => 'checkout#edit'

    #get 'admin/categories' => 'admin#categories'

  get 'category/destroy' => 'category#destroy'
  get 'category/merge' => 'category#merge'

   get 'admin/events' => 'admin#events'
  get 'event/destroy' => 'event#destroy'

  get 'admin/category_hints' => 'admin#category_hints'
  get 'category_hint/destroy' => 'category_hint#destroy'

   get 'admin/supportlinks' => 'admin#supportlinks'
   get 'admin/regions' => 'admin#regions'
   get 'supportlink/destroy' => 'supportlink#destroy'
   get 'supportlink/moveup' => 'supportlink#moveup'
   get 'supportlink/movedown' => 'supportlink#movedown'

get 'calls/new/:id' => 'calls#new'
get 'calls/listinfo/:id' => 'calls#listinfo'
get 'calls/update/:id' => 'calls#update'
get 'calls/history/:id' => 'calls#history'

get 'category/hints/:id' => 'category#hints'

get 'search', to: 'search#search'
#get '/search' => 'search#index'



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   get 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
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
  root :to => 'welcome#index' , :as => :root

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # get ':controller(/:action(/:id))(.:format)'
end
